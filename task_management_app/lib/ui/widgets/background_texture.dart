import 'package:flutter/material.dart';

class BackgroundTexture extends StatelessWidget {

  final double opacity;

  BackgroundTexture(
  {
    this.opacity = 1
  });

  @override
  Widget build(BuildContext context) {
    final toDisplay = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/GradientTexture.png"),
              fit: BoxFit.cover,
          ),
      ),
    );

    return Opacity(
      child: toDisplay,
      opacity: opacity,
    );
  }
}
