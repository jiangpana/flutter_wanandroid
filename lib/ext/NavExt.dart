import 'package:flutter/material.dart';

import '../main.dart';

bool isPortrait(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return true;
  } else {
    return false;
  }
}

void finish(){
  Navigator.pop(sContext);
}
void navTo(String route) {
  Navigator.pushNamed(sContext, route);
}

void navToPage(Widget page) {
  Navigator.push(
      sContext,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          barrierColor:Colors.black54,
          reverseTransitionDuration: Duration(milliseconds: 400),
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var curve = Curves.ease;
            var curveTween = CurveTween(curve: curve);
            var begin = Offset(0, 1);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end).chain(curveTween);
            return SlideTransition(
                position: animation.drive(tween), child: child);
          }));
}
