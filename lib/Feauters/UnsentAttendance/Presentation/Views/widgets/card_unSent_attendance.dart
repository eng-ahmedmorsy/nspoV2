import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';

import '../../ViewModel/unsent_attendance_cubit.dart';
import 'AttendanceData.dart';
import 'TypeAttendance.dart';

class CardUnsentAttendance extends StatelessWidget {
  const CardUnsentAttendance({super.key, required this.attendanceRecord});

  final AttendanceRecord attendanceRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          GestureDetector(
            onTap: () => context.read<UnsentAttendanceCubit>().sendAttendance(
                  attendanceRecord,
                ),
            child: AttendanceData(
              attendanceRecord: attendanceRecord,
            ),
          ),
          TypeAttendance(
            type: attendanceRecord.type!,
          ),
        ],
      ),
    );
  }
}
