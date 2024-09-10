import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({super.key, required this.place});

  final String place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:
          Text(place,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: context.getResponsiveFontSize(16),
                fontFamily: 'janna',
                fontWeight: FontWeight.bold,
              )),

          // Icon(Icons.location_on, size: 30, color: Colors.green.shade800),


    );
  }
}
