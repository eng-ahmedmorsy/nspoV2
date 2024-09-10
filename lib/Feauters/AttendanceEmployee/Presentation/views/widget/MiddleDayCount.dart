import 'package:flutter/material.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Presentation/views/widget/showMiddleDayAttendance.dart';

class MiddleDayCount extends StatelessWidget {
  const MiddleDayCount({super.key, required this.count, required this.middleDayList});
  final int? count;
 final List <String>  middleDayList ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMiddleDayAttendance(context, middleDayList);
      },
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Icon(
            Icons.ads_click,
            color: Colors.white,
            size: 50,
          ),
          Text(
            count.toString()?? "0",
            style: TextStyle(
                color: Colors.white,
                fontSize: context.getResponsiveFontSize(20),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "عدد مرات بصمة تواجد",
            style: TextStyle(
                color: Colors.white,
                fontSize: context.getResponsiveFontSize(20),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

List<String> list = [
  "10:00 am",
  "12:00 pm",
  "2:00 pm",
  "4:00 pm",
  "6:00 pm",
  "8:00 pm",
];
