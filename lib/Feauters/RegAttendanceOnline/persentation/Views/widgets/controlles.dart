import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/ModelView/face_detect_cubit.dart';

import '../../ViewModel/main_screen_cubit.dart';

class Controllers extends StatelessWidget {
  const Controllers({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return BlocBuilder<FaceDetectCubit, FaceDetectState>(
      builder: (context, state) {
        return cubit.faceDetectCubit.faceDetected
            ?GestureDetector(
          onTap: () => cubit.regAttendanceEmp(),
              child: Container(
                padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
              child: Icon(Icons.send, color: Colors.white,size: 30,),
                ),
            )
            : const SizedBox();
      },
    );
  }
}
