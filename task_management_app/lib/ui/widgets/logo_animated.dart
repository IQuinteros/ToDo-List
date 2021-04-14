import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class LogoAnimated extends StatefulWidget {

  final animated;
  final minWidth;
  final maxWidth;

  final bottomMargin;

  LogoAnimated({
    this.animated = true,
    this.minWidth = 200.0,
    this.maxWidth = 250.0,
    this.bottomMargin = 200.0
  });

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
    animation = Tween<double>(begin: widget.minWidth, end: widget.maxWidth).animate(controller)
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
          bottom: widget.bottomMargin
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
