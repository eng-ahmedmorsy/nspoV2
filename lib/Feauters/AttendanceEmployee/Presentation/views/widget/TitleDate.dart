import 'package:flutter/material.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';

class TitleDate extends StatelessWidget {
  const TitleDate({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -30,
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            color: Colors.teal.shade300,
            borderRadius: BorderRadius.circular(10)),
        child:  Center(
          child: Text(
            title.toString(),
            style:  TextStyle(fontSize: context.getResponsiveFontSize(25), color: Colors.white),
          ),
        ),
      ),
    );
  }
}
