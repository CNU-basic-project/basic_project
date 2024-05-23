import 'package:flutter/material.dart';

class ConsumerInfoCard extends StatelessWidget {
  const ConsumerInfoCard ({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4.0, //그림자 깊이
        child: child,
      ),
    );
  }
}
