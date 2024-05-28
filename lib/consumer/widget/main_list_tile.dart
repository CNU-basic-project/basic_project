import 'package:basicfirebase/common/no_animation_route_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/departure.dart';
import '../screen/departure_info.dart';

class ConsumerListTile extends StatelessWidget {

  final Departure departure;

  const ConsumerListTile({
    super.key,
    required this.departure
  });

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  String convertDateFormat() {
    // date == "2024-05-29 09:30:00.000"
    return DateFormat('MM월 dd일').format(departure.date);
  }

  @override
  Widget build(BuildContext context) {

    String date = convertDateFormat();

    return SizedBox(
      height: 100,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            NoAnimationRouteBuilder(builder: (context) => ConsumerDepartureInfo(departure: departure,))
          );
        },
        visualDensity: const VisualDensity(vertical: 3),
        leading: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black, width: 0.5),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: getImage(departure.ship.imagePath)
              )
          ),
        ),
        title: Text(departure.ship.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text("$date ${departure.departureTime} ~ ${departure.arrivalTime} \n${departure.departures} -> ${departure.arrivals}",
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Text("trailing"),
      ),
    );
  }
}
