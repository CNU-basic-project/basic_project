import 'package:basicfirebase/consumer/widget/main_info_list_view.dart';
import 'package:basicfirebase/consumer/widget/main_list_tile.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/departure.dart';
import '../../domain/reservation.dart';

class ConsumerListView extends StatelessWidget {
  ConsumerListView({
    super.key,
    required this.searchQuery,
    required this.dateQuery,
    required this.reservations,
  });

  late ServiceProvider serviceProvider;
  late TokenProvider tokenProvider;

  final Future<List<Reservation>> reservations;
  final String searchQuery;
  final DateTime? dateQuery;

  Future<Map> search() async {
    Map res = {
      "departures" : [],
      "reservations" : []
    };
    if (dateQuery == null) {
      if (searchQuery == "") {
        res['departures'] = await serviceProvider.departureService.findAll();
      } else {
        res['departures'] = await serviceProvider.departureService.findAllByQuery(searchQuery);
      }
    } else {
      if (searchQuery == "") {
        res['departures'] = await serviceProvider.departureService.findAllByDate(dateQuery!);
      } else {
        res['departures'] = await serviceProvider.departureService.findAllByDateAndQuery(
            dateQuery!, searchQuery);
      }
    }
    res['reservations'] = await reservations;
    return res;
  }

  @override
  Widget build(BuildContext context) {

    serviceProvider = context.read<ServiceProvider>();
    tokenProvider = context.read<TokenProvider>();

    return SizedBox(
      height: MediaQuery.of(context).size.height - ConsumerInfoListView.HEIGHT - 20,
      child: FutureBuilder(
          future: search(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false || snapshot.hasError) {
              return const CircularProgressIndicator();
            }

            Map res = snapshot.data!;
            List<Reservation?> reservations = List.filled(res['departures'].length, null);
            for (int i=0; i<res['reservations'].length; i++) {
              Reservation reservation = res['reservations'][i];
              for(int j=0; j<res['departures'].length; j++) {
                Departure departure = res['departures'][j];
                if (reservation.departure.id == departure.id) {
                  reservations[j] = reservation;
                  break;
                }
              }
            }

            return ListView.separated(
              itemCount: res['departures'].length,
              itemBuilder: (BuildContext ctx, int idx) {
                return ConsumerListTile(
                  departure: res['departures'][idx],
                  reservation: reservations[idx],
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
