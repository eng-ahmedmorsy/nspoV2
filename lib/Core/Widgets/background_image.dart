import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child, this.url, this.opacity});
  final String? url;
  final double ? opacity;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      decoration: BoxDecoration(
          image: DecorationImage(
              image: url==null ? const AssetImage(
                'assets/images/watnya.png',

              ):Image.network("$url",fit: BoxFit.cover,height: 1000,).image,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(opacity??0.4 ),
                BlendMode.modulate,
              ))),
      child: child,
    );
  }
}