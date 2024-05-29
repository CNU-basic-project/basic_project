import 'package:basicfirebase/consumer/widget/ship_info_tile.dart';
import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../domain/departure.dart';
import '../../domain/reservation.dart';
import '../widget/main_info_card.dart';

class ConsumerDepartureInfo extends StatelessWidget {

  final Departure departure;
  final Reservation? reservation;

  ConsumerDepartureInfo({
    super.key,
    required this.departure,
    required this.reservation,
  });

  late TokenProvider tokenProvider;
  late ServiceProvider serviceProvider;
  late NotifierProvider notifierProvider;

  String convertDateFormat() {
    // date == "2024-05-29 09:30:00.000"
    return DateFormat('MM월 dd일').format(departure.date);
  }

  String convertTimeFormat(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {

    tokenProvider = context.read<TokenProvider>();
    serviceProvider = context.read<ServiceProvider>();
    notifierProvider = context.read<NotifierProvider>();

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
              ConsumerShipInfoTile(title: "운행 시간", trailing: "$date ${convertTimeFormat(departure.departureTime)} ~ ${convertTimeFormat(departure.arrivalTime)}"),
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
                    String text = "예약이";
                    if (reservation == null) {
                      serviceProvider.reservationService.add(tokenProvider.token!, departure);
                    } else {
                      text = "취소가";
                      serviceProvider.reservationService.delete(tokenProvider.token!, reservation!);
                    }

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          content: Text("${departure.ship.name}의 ${text} 완료됐습니다."),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  notifierProvider.render();
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
                  child: Text(reservation == null ? "예약하기" : "취소하기", style: const TextStyle(color: Colors.white),)
                ),
              )
            ],
          ),
        ),
    );
  }
}
