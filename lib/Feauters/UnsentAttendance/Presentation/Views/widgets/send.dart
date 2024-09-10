import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';

import '../../ViewModel/unsent_attendance_cubit.dart';

class Send extends StatelessWidget {
  const Send({
    super.key,
    required this.attendanceData,
  });

  final AttendanceRecord attendanceData;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UnsentAttendanceCubit>();
    return Expanded(
      child: Container(
        height: context.height * 0.16,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.send_and_archive_outlined,
                color: Colors.teal.shade300,
                size: 50,
              ),
              onPressed: () => cubit.sendAttendance(attendanceData),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 50,
              ),
              onPressed: () {
                DailogError(context,
                    message: "هل انت متاكد من حذف الحضور",
                    nameBtn: "حذف", onPressed: () {
                  cubit.deleteAttendance(attendanceData.id!);
                  context.pop();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
