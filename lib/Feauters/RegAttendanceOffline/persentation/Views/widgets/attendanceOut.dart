import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

import '../../ViewModel/RegAttendanceOfflineCubit.dart';

class AttendanceOut extends StatelessWidget {
  const AttendanceOut({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOfflineCubit>();
    return BlocBuilder<RegAttendanceOfflineCubit, RegAttendanceOfflineState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              cubit.isMiddleDay  && cubit.attendanceData!.timeOut=="--:--"? Icons.fingerprint_sharp : Icons.logout,
              size: context.getResponsiveFontSize(50),
              color: Colors.white,
            ),
            Text(
              cubit.isMiddleDay  && cubit.attendanceData!.timeOut=="--:--"? "بصمة تواجد" : "تسجيل انصراف",
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
