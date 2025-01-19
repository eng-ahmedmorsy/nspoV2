import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/ModelView/face_detect_cubit.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/ViewModel/main_screen_cubit.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Views/widgets/controlles.dart';

import '../../../../FaceDetect/Presentation/Views/face_detect.dart';
import '../../../../UploadImageFace/presentation/ModelImage/upload_face_cubit.dart';

class FaceDetectControllers extends StatelessWidget {
  const FaceDetectControllers({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return BlocBuilder<RegAttendanceOnlineCubit, RegAttendanceOnlineState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                FaceDetectorView(),
                if (state is CaptureImageSFaceState)
                  Lottie.asset('assets/images/face_reco.json'),
              ],
            ),
            Controllers()
          ],
        );
      },
    );
  }
}
