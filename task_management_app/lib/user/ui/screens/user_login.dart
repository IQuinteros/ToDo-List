import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/background_gradient.dart';
import 'package:task_management_app/ui/widgets/background_texture.dart';
import 'package:task_management_app/ui/widgets/bottom_zeak_text.dart';
import 'package:task_management_app/ui/widgets/logo_animated.dart';
import 'package:task_management_app/user/ui/widgets/google_button.dart';

class UserLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final centerLogo = Center(
      child: LogoAnimated(
        minWidth: 150.0,
        maxWidth: 200.0,
        bottomMargin: 400.0,
      ),
    );

    final centerButton = Center(
      child: Container(
          child: GoogleButton(),
          margin: EdgeInsets.only(
              top: 100
          )
      ),
    );

    final textColumn = Column(
      children: [
        Text(
          "¡Bienvenido!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Lato"
          ),
        ),
        Text(
          "¡Organiza tus Tareas!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontFamily: "Lato"
          ),
        ),
      ],
    );

    final textBanner = Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10
      ),
      child: textColumn,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5)
      ),
    );

    final content = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textBanner,
          centerButton
        ],
      ),
    );

    final toDisplay = Stack(
      children: [
        BackgroundGradient(),
        BackgroundTexture(),
        centerLogo,
        content,
        BottomZeakText()
      ],
    );

    return toDisplay;
  }
}
