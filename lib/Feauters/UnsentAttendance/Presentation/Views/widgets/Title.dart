import 'package:flutter/cupertino.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return         const Text(" البصمات التي لم ترسل الي منظومة بعد",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,

            fontWeight: FontWeight.bold))
    ;
  }
}
