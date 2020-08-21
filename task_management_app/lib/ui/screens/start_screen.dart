import 'package:flutter/material.dart';
import 'package:task_management_app/ui/widgets/logo_animated.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backGradient = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 127, 255,0),
            Color.fromRGBO(0, 127, 255,1),
          ],
          begin:FractionalOffset(0,0),
          end: FractionalOffset(0,1)
        )
      ),
    );

    final logo = LogoAnimated();

    final centerLogo = Center(
      child: logo,
    );

    final texture = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/GradientTexture.png"),
          fit: BoxFit.cover
        )
      ),
    );

    final zeakText = Container(
      margin: EdgeInsets.only(
        bottom: 50
      ),
      alignment: Alignment.bottomCenter,
      child: Text(
        "Zeak Software",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white.withOpacity(0.9),
          fontFamily: "Conthrax",
          shadows: <Shadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 2,
              offset: Offset(0, 1)
            )
          ]
        ),
      ),
    );

    return Container(
      child: Stack(
        children: [
          backGradient,
          texture,
          centerLogo,
          zeakText
        ],
      )
    );
  }
}
