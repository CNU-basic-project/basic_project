import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  const MyLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo.png', height: size, width: size,);
  }
}
