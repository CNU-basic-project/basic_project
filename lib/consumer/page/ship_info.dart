import 'package:basicfirebase/consumer/widget/ship_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/appbar.dart';
import '../../common/constant.dart';
import '../domain/ship.dart';
import '../widget/main_info_card.dart';

class ConsumerShipInfo extends StatelessWidget {
  const ConsumerShipInfo({
    super.key,
    required this.ship
  });

  final Ship ship;

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  String convertDateFormat() {
    // date == "2024-05-29 09:30:00.000"
    List<String> s = ship.date.split(" ")[0].split("-");
    if (s[1][0] == "0") s[1] = s[1][1];
    return "${s[1]}월 ${s[2]}일";
  }

  @override
  Widget build(BuildContext context) {

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
                    image: getImage(ship.imagePath),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Center(
                child: Text(
                  ship.name,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10,),
              ConsumerShipInfoTile(title: "운행 시간", trailing: "$date ${ship.departureTime} ~ ${ship.arrivalTime}"),
              ConsumerShipInfoTile(title: "운행 경로", trailing: "${ship.arrivals} -> ${ship.departures}"),
              ConsumerShipInfoTile(title: "남은 좌석", trailing: "${ship.seat} / ${ship.maxSeat}"),
              ConsumerShipInfoTile(title: "가격 (1매)", trailing: f.format(ship.price)),
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
                          content: Text("${ship.name}의 예약이 완료됐습니다."),
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
