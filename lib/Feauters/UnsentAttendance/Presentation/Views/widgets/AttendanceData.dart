import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';
import 'package:nspo/Feauters/UnsentAttendance/Presentation/Views/widgets/send.dart';

class AttendanceData extends StatelessWidget {
  const AttendanceData({super.key, required this.attendanceRecord});

  final AttendanceRecord attendanceRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            width: context.width * 0.78,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      Text(
                        attendanceRecord.onlyDate!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.getResponsiveFontSize(20),
                        ),
                      ),
                      Text(
                        "التاريخ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: context.getResponsiveFontSize(20),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      Text(
                        attendanceRecord.onlyTime!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.getResponsiveFontSize(20),
                        ),
                      ),
                      Text(
                        "الساعة",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: context.getResponsiveFontSize(20),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Send(
            attendanceData: attendanceRecord,
          )
        ],
      ),
    );
  }
}
