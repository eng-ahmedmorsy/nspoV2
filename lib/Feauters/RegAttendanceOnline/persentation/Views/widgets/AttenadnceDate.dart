import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/Data/Models/InfoMamouria.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ViewModel/main_screen_cubit.dart';
import 'AttendanceTimes.dart';
import 'Location.dart';

class AttendanceDateEmpView extends StatelessWidget {
  const AttendanceDateEmpView({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceData? attendanceData =
        context.watch<RegAttendanceOnlineCubit>().attendanceData;
    if (attendanceData == null) {
      return const SizedBox(
      );
    }
 return  Column(
          children: [
            Location(
              place: attendanceData.nameProjects!,
            ),
             const SizedBox(
              height: 10
            ),
            AttendanceTimes(
              attendanceEmpToday: attendanceData.attendanceEmpToday!,
            ),
          ],
        );

  }
}
