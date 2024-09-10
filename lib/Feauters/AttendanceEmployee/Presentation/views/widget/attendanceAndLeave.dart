import 'package:flutter/material.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

class AttendanceAndLeave extends StatelessWidget {
  const AttendanceAndLeave({super.key,  this.attendance,  this.leave});
  final String? attendance ;
  final String? leave ;

  @override
  Widget build(BuildContext context) {
    return   Directionality(

      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          Column(
            children: [
              Text(attendance??"--:--",
                style: TextStyle(
                    color: Colors.white,
                      fontSize: context.getResponsiveFontSize(20),
                ),
              ), Text("حضور",
                style: TextStyle(
                    color: Colors.white,
                      fontSize: context.getResponsiveFontSize(20),
                ),
              ),

            ],
          ),
          Column(
            children: [
              Text(leave??"--:--",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.getResponsiveFontSize(20),
                ),
              ), Text("الانصراف",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.getResponsiveFontSize(20),
                ),
              ),

            ],
          )


        ],
      ),
    );
  }
}
