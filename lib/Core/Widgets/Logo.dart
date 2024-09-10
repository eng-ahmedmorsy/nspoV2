import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 230,
      alignment: Alignment.center,
      child: Icon(
        Icons.account_circle,
        size: 230,
        color: Colors.green.shade900,
      ),
    );
  }
}
