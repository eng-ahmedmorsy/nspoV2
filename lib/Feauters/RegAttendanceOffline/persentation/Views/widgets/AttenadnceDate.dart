import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/RegAttendanceOffline/persentation/Data/Models/InfoMamouria.dart';

import '../../ViewModel/RegAttendanceOfflineCubit.dart';
import 'AttendanceTimes.dart';
import 'Notes.dart';

class AttendanceDateEmpView extends StatelessWidget {
  const AttendanceDateEmpView({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceEmpToday? attendanceData =
        context.watch<RegAttendanceOfflineCubit>().attendanceData;
    if (attendanceData == null) {
      return const SizedBox(
      );
    }
 return  Column(
          children: [
            const Notes(
            ),
             const SizedBox(
              height: 10
            ),
            AttendanceTimes(
              attendanceEmpToday: attendanceData,
            ),
          ],
        );

  }
}
