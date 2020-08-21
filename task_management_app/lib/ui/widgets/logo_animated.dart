import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoAnimated extends StatefulWidget {
  @override
  _LogoAnimatedState createState() => _LogoAnimatedState() ;
}

class _LogoAnimatedState extends State<LogoAnimated> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 200, end: 250).animate(controller)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          controller.reverse();
        }
        else if(status == AnimationStatus.dismissed){
          controller.forward();
        }
      })
      ..addListener(() {
        setState(() {

        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animation.value,
      margin: EdgeInsets.only(
          bottom: 200
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/icon/LogoTask.png"),
          )
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
