import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ModelImage/upload_face_cubit.dart';

class BtnCapture extends StatelessWidget {
  const BtnCapture({super.key, required this.nameBtn, this.onPressed});

  final void Function()? onPressed;

  final String nameBtn;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(nameBtn, style: TextStyle(fontSize: 18)),
    );
  }
}
