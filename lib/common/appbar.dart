import 'package:basicfirebase/common/logo.dart';
import 'package:basicfirebase/common/title.dart';
import 'package:flutter/material.dart';

const preferredSize = 50.0;

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {

          },
          icon: const Icon(Icons.menu),
      ),
      actions: const [
        MyLogo(size: 40),
        SizedBox(width: 10,),
      ],
      title: const MyTitle(fontSize: 24),
      centerTitle: true,
    );
  }
}

/*

appBar: const PreferredSize(
  preferredSize: Size.fromHeight(preferredSize),
  child: MyAppBar()
),

*/
