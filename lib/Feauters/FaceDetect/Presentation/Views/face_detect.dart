import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ModelView/face_detect_cubit.dart';
import 'widgets/detector_view.dart';

class FaceDetectorView extends StatefulWidget {
  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  // To store the path of the saved image

  FaceDetectCubit? _faceDetectCubit;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _faceDetectCubit = context.read<FaceDetectCubit>();
  // }
  //
  // @override
  // void dispose() {
  //   _faceDetectCubit?.disposeFaceDetect();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<FaceDetectCubit>(context);
    return BlocBuilder<FaceDetectCubit, FaceDetectState>(
      builder: (context, state) {
        return DetectorView(
          title: 'Face Detector',
          customPaint: cubit.customPaint,
          onImage: (inputImage) => cubit.processImage(inputImage),
          initialCameraLensDirection: cubit.cameraLensDirection,
          onCameraLensDirectionChanged: (value) =>
              cubit.cameraLensDirection = value,
        );
      },
    );
  }
}
