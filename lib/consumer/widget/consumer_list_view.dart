import 'package:basicfirebase/consumer/widget/consumer_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsumerListView extends StatelessWidget {
  ConsumerListView({super.key});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ConsumerListTile> _itemList = [];

  void _getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore.collection(
        "reservations").get();
    snapshot.docs[0];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
          stream: _firestore.collection("reservations").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false || snapshot.hasError) {
              return const CircularProgressIndicator();
            }
            var items = snapshot.data!.docs;
            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext ctx, int idx) {
                return ConsumerListTile(
                    arrivalTime: items[idx]['arrivalTime'],
                    arrivals: items[idx]['arrivals'],
                    departureTime: items[idx]['departureTime'],
                    imagePath: items[idx]['imagePath'],
                    name: items[idx]['name'],
                    departures: items[idx]['departures']
                );
              },
              separatorBuilder: (BuildContext ctx, int idx) {
                return const Divider();
              },
            );
          },
      ),
    );
  }
}
