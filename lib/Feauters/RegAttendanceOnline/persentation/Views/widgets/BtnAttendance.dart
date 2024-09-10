import 'package:nspo/Core/constance/colors.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ViewModel/main_screen_cubit.dart';
import 'attenaceIN.dart';
import 'attendanceOut.dart';

class BtnAttendance extends StatelessWidget {
  const BtnAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOnlineCubit>();
    return GestureDetector(
      onTap: () {
        cubit.regAttendanceEmp(context);
      },
      child: Container(
        width: context.width * 0.8,
        height: context.height * 0.25,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(182, 244, 146, 1.0),
              Color.fromRGBO(51, 139, 147, 1.0)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 10), // Adjust the shadow position (x, y)
              blurRadius: 10, // Control the blur effect
              spreadRadius: 0.5, // Control the shadow spread
            ),
          ],
        ),
        child: Center(
          child: cubit.attendanceData?.attendanceEmpToday?.timeIn != "--:--"
              ? const AttendanceOut()
              : const AttendanceIn(),
        ),
      ),
    );
  }
}
