import 'package:basicfirebase/consumer/widget/ship_info_tile.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../domain/departure.dart';
import '../widget/main_info_card.dart';

class ConsumerDepartureInfo extends StatelessWidget {

  final Departure departure;

  ConsumerDepartureInfo({
    super.key,
    required this.departure
  });

  late TokenProvider tokenProvider;
  late ServiceProvider serviceProvider;

  String convertDateFormat() {
    // date == "2024-05-29 09:30:00.000"
    return DateFormat('MM월 dd일').format(departure.date);
  }

  @override
  Widget build(BuildContext context) {

    tokenProvider = context.read<TokenProvider>();
    serviceProvider = context.read<ServiceProvider>();

    String date = convertDateFormat();
    var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
        ),
        body: Center(
          child: ListView(
            children: [
              ConsumerInfoCard(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image(
                    image: serviceProvider.getImage(departure.ship.imagePath),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(
                child: Text(
                  departure.ship.name,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10,),
              ConsumerShipInfoTile(title: "운행 시간", trailing: "$date ${departure.departureTime} ~ ${departure.arrivalTime}"),
              ConsumerShipInfoTile(title: "운행 경로", trailing: "${departure.arrivals} -> ${departure.departures}"),
              ConsumerShipInfoTile(title: "남은 좌석", trailing: "${departure.seat} / ${departure.ship.seats}"),
              ConsumerShipInfoTile(title: "가격 (1매)", trailing: f.format(departure.price)),
              const SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.COLOR,
                  ),
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          // TODO 예약
                          content: Text("${departure.ship.name}의 예약이 완료됐습니다."),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constant.COLOR
                                ),
                                child: const Center(
                                    child: Text("확인", style: TextStyle(color: Colors.white),)
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("예매하기", style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
    );
  }
}
