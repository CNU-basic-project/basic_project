import 'package:basicfirebase/consumer/widget/consumer_list_tile.dart';
import 'package:flutter/material.dart';

class ConsumerListView extends StatelessWidget {
  ConsumerListView({super.key});

  final _itemList = <ConsumerListTile>[
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
    ConsumerListTile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
            children: _itemList,
          ),
    );
  }
}
