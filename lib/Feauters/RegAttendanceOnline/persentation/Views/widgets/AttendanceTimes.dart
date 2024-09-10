import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Data/Models/InfoMamouria.dart';

class AttendanceTimes extends StatelessWidget {
  const AttendanceTimes({super.key, required this.attendanceEmpToday});

  final AttendanceEmpToday attendanceEmpToday;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Center(
            child: Text(
              "الحضور والانصراف",
              style: TextStyle(
                  fontSize: context.getResponsiveFontSize(18),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.update,
                    color: Colors.teal,
                    size: context.getResponsiveFontSize(35),
                  ),
                  Text(
                    attendanceEmpToday.timeIn!,
                    style: TextStyle(
                        fontSize: context.getResponsiveFontSize(12),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "الحضور",
                    style: TextStyle(
                        fontSize: context.getResponsiveFontSize(16),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.update,
                    color: Colors.teal,
                    size: context.getResponsiveFontSize(35),
                  ),
                  Text(
                    attendanceEmpToday.timeOut!,
                    style: TextStyle(
                        fontSize: context.getResponsiveFontSize(12),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "الانصراف",
                    style: TextStyle(
                        fontSize: context.getResponsiveFontSize(16),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.task_alt,
                    color: Colors.teal,
                    size: context.getResponsiveFontSize(32),
                  ),
                  Text(
                    attendanceEmpToday.totalTimes!,
                    style: TextStyle(
                        fontSize: context.getResponsiveFontSize(13),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "اجمالي ساعات",
                    style: TextStyle(
                        fontSize: context.getResponsiveFontSize(16),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          attendanceEmpToday.timeIn != "--:--"
              ? Column(
                  children: [
                    Icon(
                      Icons.sync,
                      color: Colors.teal,
                      size: context.getResponsiveFontSize(32),
                    ),
                    Text(
                      attendanceEmpToday.countRegInMiddleDay.toString(),
                      style: TextStyle(
                          fontSize: context.getResponsiveFontSize(12),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "البصمات التواجد",
                      style: TextStyle(
                          fontSize: context.getResponsiveFontSize(16),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
