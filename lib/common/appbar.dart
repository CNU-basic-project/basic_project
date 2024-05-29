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
            Navigator.maybePop(context);
          },
          icon: const Icon(Icons.keyboard_backspace),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.menu)
        ),
        const SizedBox(width: 10,),
      ],
      centerTitle: true,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
       children: [
         MyLogo(size: 16),
         SizedBox(width: 5,),
         MyTitle(fontSize: 24),
       ],
      ),
    );
  }
}

/*

appBar: const PreferredSize(
  preferredSize: Size.fromHeight(preferredSize),
  child: MyAppBar()
),

*/
