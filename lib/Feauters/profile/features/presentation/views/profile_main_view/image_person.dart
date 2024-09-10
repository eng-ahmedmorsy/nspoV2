import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePerson extends StatelessWidget {
  const ImagePerson({super.key});

  @override
  Widget build(BuildContext context) {
    return               CircleAvatar(
      radius: 60,
      backgroundColor: Colors.teal.shade300,
      child: const Icon(Icons.person, size: 100, color: Colors.white),
    )
    ;
  }
}
