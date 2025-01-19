import 'dart:io';
import 'dart:ui';
import 'dart:ui';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Core/servies/ErrorLocateLocation.dart';
import 'package:nspo/Core/utils/app_router.dart';
import 'package:nspo/Feauters/RegAttendanceOffline/persentation/ViewModel/RegAttendanceOfflineCubit.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/ViewModel/main_screen_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Views/widgets/face_detector_painter.dart';

part 'face_detect_state.dart';

class FaceDetectCubit extends Cubit<FaceDetectState> {
  FaceDetectCubit() : super(FaceDetectInitial());

  // final RegAttendanceOnlineCubit regAttendanceOnlineCubit;
  // final RegAttendanceOfflineCubit regAttendanceOfflineCubit;

  bool faceDetected = false;
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? customPaint;
  CameraImage? cameraImage;
  List<CameraDescription> cameras = [];
  CameraController? controller;
  int cameraIndex = -1;

  var cameraLensDirection = CameraLensDirection.front;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: false,
    ),
  );

  void faceDetectedChange(bool value) {
    faceDetected = value;
    emit(FaceDetectedChangeState());
  }

  // Future<void> _startLiveFeed() async {
  //   if (controller != null && controller!.value.isInitialized) {
  //     return;
  //   }
  //
  //   final camera = cameras[_cameraIndex];
  //   controller = CameraController(
  //     camera,
  //     ResolutionPreset.high,
  //     enableAudio: false,
  //     imageFormatGroup: Platform.isAndroid
  //         ? ImageFormatGroup.nv21
  //         : ImageFormatGroup.bgra8888,
  //   );
  //
  //   try {
  //     await controller!.initialize();
  //     controller!.startImageStream(_processCameraImage);
  //   } catch (e) {
  //     print("Error initializing the camera: $e");
  //   }
  // }

  Future<void> stopLiveFeed() async {
    if (controller != null && controller!.value.isInitialized) {
      await controller?.stopImageStream();
      await controller?.dispose();
      controller = null;
      faceDetectedChange(false);
    }
  }

  void processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);

    if (inputImage == null) return;
    processImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = cameras[cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${controller?.value.deviceOrientation} ${controller?.value.lockedCaptureOrientation} ${controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  disposeFaceDetect() {
    _canProcess = false;
    _faceDetector.close();
  }

  // void initialize() async {
  //   if (cameras.isEmpty) {
  //     cameras = await availableCameras();
  //   }
  //   for (var i = 0; i < cameras.length; i++) {
  //     if (cameras[i].lensDirection == cameraLensDirection) {
  //       _cameraIndex = i;
  //       break;
  //     }
  //   }
  //   if (_cameraIndex != -1) {
  //     _startLiveFeed();
  //   }
  // }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    _isBusy = true;
    // _inputImage = inputImage;

    final faces = await _faceDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        cameraLensDirection,
      );
      customPaint = CustomPaint(painter: painter);
      changeCustomPaint(customPaint!);

      if (faces.isNotEmpty) {
        for (final face in faces) {
          if (_isFaceClear( face,inputImage)) {
            faceDetectedChange(true);
            // _saveInputImage(inputImage);
            // disposeFaceDetect();



            break;
          } else {
            faceDetectedChange(false);
          }
        }
      } else {
        faceDetectedChange(false);
      }
    }

    _isBusy = false;
  }

  bool _isFaceClear(Face face,InputImage inputImage) {
    // التحقق من أن الوجه كبير بما يكفي (يمكن تعديل هذا حسب احتياجاتك)
    final imageSize = inputImage.metadata!.size;

    double minFaceSize = 200.0;
    if (face.boundingBox.width < minFaceSize || face.boundingBox.height < minFaceSize) {
      return false;
    }
    // print('وجه واضح'*100);
    //
    // // التحقق من أن الوجه متمركز في وسط الإطار بشكل أكثر دقة
    // double centerX = face.boundingBox.center.dx;
    // double centerY = face.boundingBox.center.dy;
    // double imageWidth = imageSize.width;
    // double imageHeight = imageSize.height;
    //
    // // تحديد النطاق المركزي للوجه بحيث يكون الوجه داخل نسبة 40% من منتصف الصورة
    // double horizontalMargin = imageWidth * 0.5; // 20% من العرض على كل جانب
    // double verticalMargin = imageHeight * 0.5;  // 20% من الارتفاع على كل جانب
    //
    // // التحقق مما إذا كان الوجه ضمن النطاق المركزي
    // if (centerX < horizontalMargin || centerX > imageWidth - horizontalMargin ||
    //     centerY < verticalMargin || centerY > imageHeight - verticalMargin) {
    //   return false;
    // }

    // print('وجه واضح'*100);


    // التحقق من وجود ملامح الوجه الرئيسية (العيون، الأنف، الفم)
    // if (
    // face.landmarks[FaceLandmarkType.rightEar] == null
    //     // face.landmarks[FaceLandmarkType.rightEye] == null
    //     // face.landmarks[FaceLandmarkType.noseBase] == null
    //       ){
    //
    //   return false;
    // }

    // إذا تحققت كل الشروط السابقة، فإن الوجه واضح
    return true;
  }



  changeCustomPaint(CustomPaint customPaint) {
    this.customPaint = customPaint;
    emit(ChangeCustomPaintState());
  }

  // Future<void> _saveInputImage(InputImage inputImage) async {
  //   try {
  //
  //     // مثال لتوليد صورة جديدة (يفترض أن لديك imageBytes):
  //     Uint8List uint8List = Uint8List.fromList(inputImage.bytes!);
  //
  //
  //     // تحويل البيانات الثنائية إلى صورة
  //     img.Image? image = img.decodeImage(uint8List);
  //
  //     // الحصول على مسار مجلد التحميلات
  //     final Directory? downloadsDirectory = await getDownloadsDirectory();
  //     final String imagePath = '${downloadsDirectory!.path}/saved_image.png';
  //
  //     // حفظ الصورة
  //     final File imageFile = File(imagePath);
  //     await imageFile.writeAsBytes(img.encodePng(image!));
  //
  //     print('Image saved at $imagePath');
  //
  //     print('Image saved at $imagePath');
  //   } catch (e) {
  //     print('Error saving image: $e');
  //   }
  // }


//   CaptureImage() async {
//     XFile? image = await controller?.takePicture();
//
//     if (image != null) {
//       var status = await Permission.storage.request();
//       if (status.isGranted) {
//         // الحصول على مسار مجلد التنزيلات
//         Directory? downloadsDir = await getDownloadsDirectory();
//
//         if (downloadsDir != null) {
//           String newPath = '${downloadsDir.path}/${DateTime
//               .now()
//               .millisecondsSinceEpoch}.jpg';
//           File newImageFile = File(newPath);
//
//           // نسخ الصورة من المسار المؤقت إلى مجلد التنزيلات
//           await newImageFile.writeAsBytes(await image.readAsBytes());
//
//           print('تم حفظ الصورة في: $newPath');
//         }
//     // regAttendanceOnlineCubit.regAttendanceEmp(compressedImageFile.path);
//   }
// }}
}
