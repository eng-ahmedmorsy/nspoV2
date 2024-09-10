import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension ResponsiveTextExtension on BuildContext {
  double getResponsiveFontSize(double baseFontSize) {
    double screenWidth = MediaQuery.of(this).size.width;
    // Adjust the text size based on screen width
    return baseFontSize * (screenWidth / 375);
  }
}
