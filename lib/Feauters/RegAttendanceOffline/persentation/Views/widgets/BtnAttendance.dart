import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ViewModel/RegAttendanceOfflineCubit.dart';
import 'attenaceIN.dart';
import 'attendanceOut.dart';

class BtnAttendance extends StatelessWidget {
  const BtnAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegAttendanceOfflineCubit>();
    return GestureDetector(
      onTap: () {
        cubit.regAttendanceEmp(context);
      },
      child: Container(
        width: context.width * 0.8,
        height: context.height * 0.25,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(0.004, 0.48), // تمثل نسبة 0.4% و 48% في Flutter
            radius: 666 / 1000, // 666px/1000px
            colors: [
              Color.fromRGBO(202, 204, 227, 1), // rgb(202, 204, 227)
              Color.fromRGBO(89, 89, 99, 1), // rgb(89, 89, 99)
            ],
            stops: [0.0, 0.975], // 0% و 97.5%
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
          child: cubit.attendanceData?.timeIn != "--:--"
              ? const AttendanceOut()
              : const AttendanceIn(),
        ),
      ),
    );
  }
}
