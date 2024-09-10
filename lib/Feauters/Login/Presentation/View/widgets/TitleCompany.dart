import 'package:flutter/material.dart';

class TitleCompany extends StatelessWidget {
  const TitleCompany({super.key});

  @override
  Widget build(BuildContext context) {
    double defaultFontSize = 17;

    return           Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "يارب ",
            style: TextStyle(
              color: Colors.green.shade900,
              fontSize: defaultFontSize,
              fontStyle: FontStyle.normal,
            ),
          ),
          Text(
            " نتمني من الله ان يكون البرنامج عند حسن الظن",
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: defaultFontSize,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    )
      ;
  }
}
