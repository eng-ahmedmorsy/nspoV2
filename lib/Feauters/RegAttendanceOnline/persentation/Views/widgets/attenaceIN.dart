import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

class AttendanceIn extends StatelessWidget {
  const AttendanceIn({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.login,
          size: context.getResponsiveFontSize(50),
          color: Colors.white,
        ),
        Text(
          "تسجيل حضور",
          style: TextStyle(
            fontSize: context.getResponsiveFontSize(22),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
