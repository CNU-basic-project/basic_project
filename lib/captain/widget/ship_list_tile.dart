import 'package:basicfirebase/captain/screen/ship_register.dart';
import 'package:basicfirebase/common/constant.dart';
import 'package:basicfirebase/common/no_animation_route_button.dart';
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
        Navigator.push(
          context,
          NoAnimationRouteBuilder(builder: (builder) => ShipRegister(ship: ship))
        );
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
        ],
      ),
      trailing: const Icon(Icons.drive_file_move_outlined, color: Constant.COLOR,),
    );
  }
}
