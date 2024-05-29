import 'package:flutter/material.dart';

class NoAnimationRouteBuilder<T> extends MaterialPageRoute<T> {
  NoAnimationRouteBuilder({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
    // const begin = Offset(0.0, 1.0);
    // const end = Offset.zero;
    // const curve = Curves.ease;
    // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    // final offsetAnimation = animation.drive(tween);
    // return SlideTransition(
    //   position: offsetAnimation,
    //   child: child,
    // );
  }
}