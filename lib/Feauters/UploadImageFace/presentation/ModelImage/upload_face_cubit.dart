import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/ModelView/face_detect_cubit.dart';
import 'package:image/image.dart' as img;
import 'package:nspo/Feauters/UploadImageFace/Data/Repository/UploadImageFaceRepo.dart';
import 'package:nspo/Feauters/UploadImageFace/Data/Repository/UploadImageFaceRepoImpl.dart';

import '../../../../Core/servies/sharedPerf.dart';

part 'upload_face_state.dart';

class UploadFaceCubit extends Cubit<UploadFaceState> {
  UploadFaceCubit(this.faceDetectCubit) : super(UploadFaceInitial());
  bool isAccepted = false;
  final FaceDetectCubit faceDetectCubit;
  String imagePath = '';

  changeAccepted() {
    isAccepted = !isAccepted;
    emit(ChangeAcceptedState());
  }

  Future<File> CaptureImage() async {
    XFile? image = await faceDetectCubit.controller?.takePicture();

    File imageFile = File(image!.path);
    List<int> imageBytes = await imageFile.readAsBytes();

    Uint8List uint8list = Uint8List.fromList(imageBytes);

    img.Image? originalImage = img.decodeImage(uint8list);

    img.Image resizedImage = img.copyResize(
      originalImage!,
      width: 600,
    );

    List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 80);

    File compressedImageFile =
        await File(image.path).writeAsBytes(compressedBytes);

    return compressedImageFile;
  }

  ShowImage() async {
    emit(ShowImageLoadingState());

    File pathImage = await CaptureImage();
    imagePath = pathImage.path;

    emit(ShowImageState());
  }

  repeatTakeImage() {
    imagePath = '';
    emit(RepeatTakeImageState());
  }

  sendImageFace() async {
    emit(SendImageLoadingState());
    UploadImageFaceRepoImpl uploadImageFaceRepoImpl = UploadImageFaceRepoImpl();
    int personalId = await getPersonalId();
    ;
    var response =
        await uploadImageFaceRepoImpl.uploadImageFace(imagePath, personalId);
    response.fold(
      (l) {
        emit(SendImageErrorState());
      },
      (r) {
        emit(SendImageSuccessState());
      },
    );
  }

  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }
}
