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
  }
}