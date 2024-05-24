import 'package:flutter/material.dart';

class ConsumerShipInfo extends StatelessWidget {
  const ConsumerShipInfo({
    super.key,
    required this.date,
    required this.arrivalTime,
    required this.arrivals,
    required this.departureTime,
    required this.imagePath,
    required this.name,
    required this.departures,
  });

  final String imagePath, arrivalTime, arrivals, departureTime, departures, name, date;

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  String convertDateFormat() {
    // date == "2024-05-29 09:30:00.000"
    List<String> s = date.split(" ")[0].split("-");
    if (s[1][0] == "0") s[1] = s[1][1];
    return "${s[1]}월 ${s[2]}일";
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
