import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/bottom_zeak_text.dart';
import 'package:task_management_app/ui/widgets/logo_animated.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backGradient = BackgroundGradient();

    final logo = LogoAnimated();

    final centerLogo = Center(
      child: logo,
    );

    final texture = BackgroundTexture();

    final zeakText = BottomZeakText();

    final progress = Center(
      child: Container(
        margin: EdgeInsets.only(
          top: 200
        ),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );

    return Container(
      child: Stack(
        children: [
          backGradient,
          texture,
          centerLogo,
          progress,
          zeakText
        ],
      )
    );
  }
}
