import 'package:flutter/material.dart';

class BottomZeakText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
