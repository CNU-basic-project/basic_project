import 'package:basicfirebase/consumer/widget/consumer_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/consumer_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsumerListView extends StatelessWidget {
  ConsumerListView({
    super.key,
    required this.searchQuery,
    required this.dateQuery,
  });

  static const checkField = ["name", "departures", "arrivals"];
  final String searchQuery;
  final DateTime? dateQuery;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height - ConsumerInfoListView.HEIGHT - 20,
      child: FutureBuilder(
          future: _firestore.collection("reservations").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false || snapshot.hasError) {
              return const CircularProgressIndicator();
            }

            List<dynamic> items = snapshot.data!.docs;
            items = items.where((element) {
              if (dateQuery != null) { // 날짜 검색을 한다면
                String elementDate = element['date'].toString().split(" ")[0];
                String dateQueryDate = dateQuery.toString().split(" ")[0];
                if (dateQueryDate != elementDate) return false; // 날짜가 같지 않으면 false
              }

              for (String field in checkField) {
                if (element[field].toString().contains(searchQuery)) return true; // 검색 확인
              }
              return false;
            }).toList();

            return ListView.separated(
              itemCount: items.length,
              itemBuilder: (BuildContext ctx, int idx) {
                return ConsumerListTile(
                    date: items[idx]['date'],
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
