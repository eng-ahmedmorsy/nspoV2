import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/Views/face_detect.dart';
import 'package:nspo/Feauters/UploadImageFace/presentation/Views/widgets/UploadImageFaceViewBody.dart';
import '';


class UploadImageFaceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UploadImageFaceViewBody()
      ),
    );
  }
}
