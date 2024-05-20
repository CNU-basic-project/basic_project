import 'package:flutter/material.dart';

const preferredSize = 50.0;

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: const Text("Hi"),
    );
  }
}

/*
appBar: const PreferredSize(
  preferredSize: Size.fromHeight(preferredSize),
  child: MyAppBar()
)
 */
