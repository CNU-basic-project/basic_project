import 'package:basicfirebase/captain/screen/departure_register.dart';
import 'package:basicfirebase/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/constant.dart';
import '../../common/no_animation_route_button.dart';
import '../../domain/departure.dart';
import '../../domain/ship.dart';

class DepartureListTile extends StatelessWidget {

  final Departure departure;

  DepartureListTile({
    super.key,
    required this.departure,
  });

  String convertDateFormat() {
    // date == "2024-05-29 09:30:00.000"
    return DateFormat('MM월 dd일').format(departure.date);
  }

  String convertTimeFormat(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  var f = NumberFormat.currency(locale: "ko_KR", symbol: "￦");

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            NoAnimationRouteBuilder(builder: (builder) => DepartureRegister(ship: departure.ship, departure: departure))
        );
      },
      leading: Text(convertDateFormat(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      title: Text("${departure.departures} -> ${departure.arrivals}",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${convertTimeFormat(departure.departureTime)} ~ ${convertTimeFormat(departure.arrivalTime)}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text("좌석 : ${departure.seat}/${departure.ship.seats} \n 가격 : ${f.format(departure.price)}")
        ],
      ),
      trailing: const Icon(Icons.drive_file_move_outlined, color: Constant.COLOR,),
    );
  }
}