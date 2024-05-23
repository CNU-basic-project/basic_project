import 'package:flutter/material.dart';

class ConsumerListTile extends StatelessWidget {
  const ConsumerListTile({
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

    String date = convertDateFormat();

    return SizedBox(
      height: 100,
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 3),
        leading: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black, width: 0.5),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: getImage(imagePath)
              )
          ),
        ),
        title: Text(name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text("$date $departureTime ~ $arrivalTime \n$arrivals -> $departures",
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Text("trailing"),
      ),
    );
  }
}
