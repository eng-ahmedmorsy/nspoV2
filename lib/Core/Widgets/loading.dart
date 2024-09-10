import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // color: Colors.black.withOpacity(0.5),
        Lottie.asset('assets/images/loading.json');
  }
}
