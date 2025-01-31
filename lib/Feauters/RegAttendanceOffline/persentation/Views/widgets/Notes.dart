import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Wrap(
          children: [
            Text(" انت في وضع offline",
                style: TextStyle(
                  fontSize: context.getResponsiveFontSize(16),
                  fontFamily: 'janna',
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.wifi_off, size: 30, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
