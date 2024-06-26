import 'dart:math';

import 'package:basicfirebase/common/exception/reject_reservation_exception.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
import 'package:basicfirebase/consumer/screen/departure_detail.dart';
import 'package:basicfirebase/consumer/widget/ship_info_tile.dart';
import 'package:basicfirebase/provider/notifier_provider.dart';
import 'package:basicfirebase/provider/service_provider.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../../common/drawer.dart';
import '../../domain/departure.dart';
import '../../domain/reservation.dart';
import '../widget/main_info_card.dart';
import 'departure_map.dart';

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
      backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
        ),
        endDrawer: MyDrawer(),
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
                onTap: () {
                  Navigator.push(context, NoAnimationRouteBuilder(builder: (builder) => DepartureDetail(departure: departure)));
                },
              ),
              const SizedBox(height: 10,),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, NoAnimationRouteBuilder(builder: (builder) => DepartureDetail(departure: departure)));
                  },
                  child: Column(
                    children: [
                      Text(
                        departure.ship.name,
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const Text("더보기", style: TextStyle(color: Colors.grey, fontSize: 10),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              ConsumerShipInfoTile(title: "운행 시간", trailing: "$date ${convertTimeFormat(departure.departureTime)} ~ ${convertTimeFormat(departure.arrivalTime)}",
                onTap: () {

                },
              ),
              const SizedBox(height: 10,),
              ConsumerShipInfoTile(title: "운행 경로", trailing: "${departure.departures} -> ${departure.arrivals}",
                onTap: () {
                  Navigator.push(
                    context,
                    NoAnimationRouteBuilder(builder: (builder) => DepartureMap(departure: departure))
                  );
                },
              ),
              const SizedBox(height: 10,),
              ConsumerShipInfoTile(title: "남은 좌석", trailing: "${departure.seat} / ${departure.ship.seats}",
                onTap: () {

                },
              ),
              const SizedBox(height: 10,),
              ConsumerShipInfoTile(title: "가격 (1매)", trailing: f.format(departure.price),
                onTap: () {

                },
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.COLOR,
                  ),
                  onPressed: () async {

                    String text = "";
                    try {
                      text = "예약이";
                      if (reservation == null) {
                        await serviceProvider.reservationService.add(
                            tokenProvider.token!, departure);
                      } else {
                        text = "취소가";
                        await serviceProvider.reservationService.delete(
                            tokenProvider.token!, reservation!);
                      }
                    } on RejectReservationException catch (e) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Text(e.toString()),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Constant.COLOR
                                ),
                                child: const Text("확인", style: TextStyle(color: Colors.white),),
                              )
                            ],
                          );
                        },
                      );
                      return;
                    }

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Text("${departure.ship.name}의 $text 완료됐습니다."),
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
