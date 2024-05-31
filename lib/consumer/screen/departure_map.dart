import 'package:flutter/material.dart';

import '../../common/appbar.dart';
import '../../common/drawer.dart';
import '../../domain/departure.dart';

class DepartureMap extends StatelessWidget {

  final Departure departure;

  DepartureMap({
    required this.departure,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      endDrawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(width: 17),
            Text("${departure.departures} ↔ ${departure.arrivals}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            Center(child: Image.asset("assets/route.png", width: 350, height: 450,)),
          ],
        ),
      ),
    );
  }
}