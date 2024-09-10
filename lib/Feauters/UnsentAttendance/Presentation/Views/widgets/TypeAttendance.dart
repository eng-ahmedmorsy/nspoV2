import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeAttendance extends StatelessWidget {
  const TypeAttendance({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -27,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(

          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.shade300, width: 2),
        ),
        child:                        Center(
          child: Text(
           type,
            style: TextStyle(
                color: Colors.teal.shade300,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),

      ),
    )
    ;
  }
}
