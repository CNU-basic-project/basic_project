import 'package:basicfirebase/common/constant.dart';
import 'package:flutter/material.dart';

import '../../domain/ship.dart';

class ShipListTile extends StatelessWidget {

  final Ship ship;

  const ShipListTile({
    super.key,
    required this.ship,
  });

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // TODO move to ship_info which has departure button
      },
      leading: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black, width: 0.5),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: getImage(ship.imagePath)
            )
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(ship.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          //reservation != null ? const Icon(Icons.check, color: Colors.green,) : const Text(""),
        ],
      ),
      // subtitle: Text("$date ${convertTimeFormat(departure.departureTime)} ~ ${convertTimeFormat(departure.arrivalTime)}\n${departure.departures} -> ${departure.arrivals}",
      //   style: const TextStyle(fontSize: 16),
      // ),
      trailing: const Icon(Icons.drive_file_move_outlined, color: Constant.COLOR,),
      // trailing: Text("${departure.seat} / ${departure.ship.seats}"),
    );
  }
}
