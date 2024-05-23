import 'package:basicfirebase/common/search_field.dart';
import 'package:basicfirebase/consumer/widget/consumer_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/consumer_list_view.dart';
import 'package:flutter/material.dart';

import '../../common/appbar.dart';
import '../../common/no_animation_route_button.dart';
import '../../main.dart';

class ConsumerMain extends StatelessWidget {
  const ConsumerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ConsumerInfoListView(),
            const SizedBox(height: 20,),
            SearchField(),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                NoAnimationRouteBuilder(builder: (context) => MyHomePage(title: 'Firebase Analytics Event', analytics: MyApp.analytics))
              );
            }
                , child: Icon(Icons.smart_button)),
            const SizedBox(height: 20,),
            ConsumerListView(),
          ],
        ),
      ),
    );
  }
}
