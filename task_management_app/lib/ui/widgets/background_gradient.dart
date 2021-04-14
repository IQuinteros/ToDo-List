import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {

  final double maxOpacity;

  BackgroundGradient({
    this.maxOpacity = 1
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 127, 255,0),
                Color.fromRGBO(0, 127, 255,maxOpacity),
              ],
              begin:FractionalOffset(0,0),
              end: FractionalOffset(0,1)
          )
      ),
    );
  }
}
