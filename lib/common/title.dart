import 'package:basicfirebase/common/constant.dart';
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
      color: Constant.COLOR,
      fontFamily: "Inria Sans",
    ),);
  }
}
