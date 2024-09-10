import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Data/Model/attendance.dart';

import 'MiddleDayCount.dart';
import 'TitleDate.dart';
import 'attendanceAndLeave.dart';

class CardAttendance extends StatelessWidget {
  const CardAttendance({super.key, this.attendanceEmployee});

  final AttendanceEmployee? attendanceEmployee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: attendanceEmployee?.attendance != null
                    ? Column(
                        children: [
                          AttendanceAndLeave(
                            attendance:
                                attendanceEmployee?.attendance?.attend?.hour,
                            leave: attendanceEmployee?.attendance?.leave?.hour,
                          ),
                          MiddleDayCount(
                              count: attendanceEmployee
                                  ?.attendance?.middleDayCount,
                              middleDayList: attendanceEmployee
                                      ?.attendance?.middleDay
                                      ?.map((e) => e.hour.toString())
                                      .toList() ??
                                  [])
                        ],
                      )
                    : Column(
                        children: [
                          const Text(
                            "لم يحضر في هذا اليوم",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
              ),
            ),
          ),
          TitleDate(
            title: attendanceEmployee!.date.toString(),
          )
        ],
      ),
    );
  }
}
