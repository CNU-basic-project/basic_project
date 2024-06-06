import 'package:basicfirebase/common/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/appbar.dart';
import '../../domain/departure.dart';
import '../widget/main_info_card.dart';

class DepartureDetail extends StatelessWidget {

  final Departure departure;
  final int probability;

  DepartureDetail({
    super.key,
    required this.departure,
    required this.probability,
  });

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(preferredSize),
          child: MyAppBar()
      ),
      endDrawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConsumerInfoCard(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image(
                  image: getImage(departure.ship.imagePath),
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
              },
            ),
            const SizedBox(height: 20,),
            Text(departure.ship.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Container(
              height: 240,
              width: 320,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: probability > 50 ? Colors.blue : Colors.red, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat("yyyy.MM.dd").format(departure.date), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text("약", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 10,),
                      Text("$probability%", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: probability > 50 ? Colors.blue : Colors.red),),
                      const SizedBox(width: 10,),
                      const Text("의 확률로 출항합니다.", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text("날씨: 맑음", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const Text("시계 제한: O(안개)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  const Text("풍랑 및 폭풍해일 주의보: X", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
