import 'package:flutter/material.dart';

class ConsumerListTile extends StatelessWidget {
  const ConsumerListTile({
    super.key,
    required this.arrivalTime,
    required this.arrivals,
    required this.departureTime,
    required this.imagePath,
    required this.name,
    required this.departures,
  });

  final String imagePath, arrivalTime, arrivals, departureTime, departures, name;

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  @override
  Widget build(BuildContext context) {
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
        subtitle: Text("$departureTime ~ $arrivalTime \n$arrivals -> $departures",
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Text("trailing"),
      ),
    );
  }
}
