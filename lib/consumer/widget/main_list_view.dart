import 'package:basicfirebase/consumer/widget/main_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/main_list_tile.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/departure.dart';

class ConsumerListView extends StatelessWidget {
  ConsumerListView({
    super.key,
    required this.searchQuery,
    required this.dateQuery,
  });

  late ServiceProvider serviceProvider;

  final String searchQuery;
  final DateTime? dateQuery;

  Future<List<Departure>> search() async {
    if (dateQuery == null) {
      if (searchQuery == "") {
        return await serviceProvider.departureService.findAll();
      }
      return await serviceProvider.departureService.findAllByQuery(searchQuery);
    }
    if (searchQuery == "") return await serviceProvider.departureService.findAllByDate(dateQuery!);
    return await serviceProvider.departureService.findAllByDateAndQuery(dateQuery!, searchQuery);
  }

  @override
  Widget build(BuildContext context) {

    serviceProvider = context.read<ServiceProvider>();

    return SizedBox(
      height: MediaQuery.of(context).size.height - ConsumerInfoListView.HEIGHT - 20,
      child: FutureBuilder(
          future: search(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false || snapshot.hasError) {
              return const CircularProgressIndicator();
            }

            List<Departure> departures = snapshot.data!;

            return ListView.separated(
              itemCount: departures.length,
              itemBuilder: (BuildContext ctx, int idx) {
                return ConsumerListTile(
                  departure: departures[idx],
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
