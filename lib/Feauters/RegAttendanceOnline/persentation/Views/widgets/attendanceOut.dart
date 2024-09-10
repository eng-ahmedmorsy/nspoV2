import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

import '../../ViewModel/main_screen_cubit.dart';

class AttendanceOut extends StatelessWidget {
  const AttendanceOut({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return BlocBuilder<RegAttendanceOnlineCubit, RegAttendanceOnlineState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              cubit.isMiddleDay  && cubit.attendanceData!.attendanceEmpToday!.timeOut=="--:--"? Icons.fingerprint_sharp : Icons.logout,
              size: context.getResponsiveFontSize(50),
              color: Colors.white,
            ),
            Text(
              cubit.isMiddleDay  && cubit.attendanceData!.attendanceEmpToday!.timeOut=="--:--"? "بصمة تواجد" : "تسجيل انصراف",
              style:  TextStyle(
                fontSize: context.getResponsiveFontSize(22),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
