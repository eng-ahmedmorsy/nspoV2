import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusRequest extends StatelessWidget {
  const StatusRequest({super.key, required this.status});
   final bool? status ;
  @override
  Widget build(BuildContext context) {
    return status == null
        ? Image.asset("assets/images/v.png",
        color: Colors.black.withOpacity(0.4),
        colorBlendMode: BlendMode.dstIn
    )
        : status == true
        ? Image.asset(
        "assets/images/accpeted.png",
        color: Colors.black.withOpacity(0.4),
        colorBlendMode: BlendMode.dstIn
    )
        : Image.asset("assets/images/refused.png",
        color: Colors.black.withOpacity(0.4),
    colorBlendMode: BlendMode.dstIn
    );
  }
}
