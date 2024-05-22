import 'package:basicfirebase/consumer/widget/consumer_list_view.dart';
import 'package:flutter/material.dart';

import '../../common/appbar.dart';

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
        child: ConsumerListView(),
      ),
    );
  }
}
