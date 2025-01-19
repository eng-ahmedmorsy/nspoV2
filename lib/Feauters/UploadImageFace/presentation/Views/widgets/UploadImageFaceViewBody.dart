import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/UploadImageFace/presentation/Views/widgets/ShowImageFace.dart';
import 'package:nspo/Feauters/UploadImageFace/presentation/Views/widgets/TakeCaputureCard.dart';

import '../../../../FaceDetect/Presentation/Views/face_detect.dart';
import '../../ModelImage/upload_face_cubit.dart';

class UploadImageFaceViewBody extends StatelessWidget {
  const UploadImageFaceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UploadFaceCubit>();
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<UploadFaceCubit, UploadFaceState>(
          builder: (context, state) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: cubit.imagePath == ''
                      ? TakeCaptureCard()
                      : ShowImageFace()),
            );
          },
        ),
      ),
    );
  }
}
