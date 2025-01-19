import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/ModelView/face_detect_cubit.dart';

class CameraView extends StatefulWidget {
  CameraView({
    Key? key,
    required this.customPaint,
    required this.onImage,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,
  }) : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  FaceDetectCubit? _faceDetectCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _faceDetectCubit = context.read<FaceDetectCubit>();
    if (_faceDetectCubit != null) {
      _initialize();
    }
  }

  void _initialize() async {
    if (_faceDetectCubit!.cameras.isEmpty) {
      _faceDetectCubit!.cameras = await availableCameras();
    }

    for (var i = 0; i < _faceDetectCubit!.cameras.length; i++) {
      if (_faceDetectCubit!.cameras[i].lensDirection ==
          widget.initialCameraLensDirection) {
        _faceDetectCubit!.cameraIndex = i;
        break;
      }
    }

    if (_faceDetectCubit!.cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _faceDetectCubit!.stopLiveFeed();
    super.dispose();
  }

  Future _startLiveFeed() async {
    if (_faceDetectCubit?.controller != null &&
        _faceDetectCubit!.controller!.value.isInitialized) {
      return;
    }
    final camera = _faceDetectCubit!.cameras[_faceDetectCubit!.cameraIndex];

    _faceDetectCubit?.controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _faceDetectCubit?.controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _faceDetectCubit?.controller
          ?.startImageStream(_faceDetectCubit!.processCameraImage)
          .then((value) {});

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FaceDetectCubit>(context);
    // if (cubit.cameras.isEmpty) return Container();
    if (cubit.controller == null) return Container();
    if (cubit.controller?.value.isInitialized == false) return Container();
   return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
     child: ClipOval(
     child: AspectRatio(
       aspectRatio: 1.0,
       child: CameraPreview(
         cubit.controller!,
         child: cubit.customPaint,
       ),
     ),
          ),
   );



  }
}
