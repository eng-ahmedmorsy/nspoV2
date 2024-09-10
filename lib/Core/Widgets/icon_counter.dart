import 'package:flutter/material.dart';

class IconWithCounter extends StatelessWidget {
  final IconData icon;
  final int counter;
  final double size;
  final Color color;

  const IconWithCounter({super.key,
    required this.icon,
    required this.counter,
    this.size = 24.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          icon,
          size: size,
          color: color,
        ),
        if (counter > 0)  // Show badge only if counter is greater than 0
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                '$counter',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
