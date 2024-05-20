import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({super.key, required this.fontSize, this.fontWeight=FontWeight.normal});

  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text("Blue Ocean", style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: const Color(0xFF0039FF),
      fontFamily: "Inria Sans",
    ),);
  }
}
