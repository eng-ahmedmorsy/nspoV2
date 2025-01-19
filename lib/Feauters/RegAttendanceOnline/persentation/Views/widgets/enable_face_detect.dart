import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/ViewModel/main_screen_cubit.dart';
import 'package:nspo/Feauters/UploadImageFace/presentation/Views/widgets/btn_capture.dart';

class EnableFaceDetect extends StatelessWidget {
  const EnableFaceDetect({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return Column(
      children: [
        Image.asset(
          'assets/images/face.png',
          height: 200,
          width: 200,
        ),
        SizedBox(height: 20),
        BtnCapture(
            nameBtn: "تسجيل بصمة", onPressed: () => cubit.enableFaceDetect()),
      ],
    );
  }
}
