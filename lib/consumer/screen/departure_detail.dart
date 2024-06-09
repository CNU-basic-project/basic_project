import 'package:basicfirebase/common/constant.dart';
import 'package:basicfirebase/common/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../domain/departure.dart';
import '../../provider/service_provider.dart';
import '../widget/main_info_card.dart';

class DepartureDetail extends StatelessWidget {

  final Departure departure;
  late ServiceProvider serviceProvider;

  DepartureDetail({
    super.key,
    required this.departure,
  });

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }

  Future<String> _fetchData() async {
    String name = departure.departures;
    if (!PLACE.containsKey(name)) name = "테스트";
    double latitude = PLACE[name]!['latitude']!;
    double longitude = PLACE[name]!['longitude']!;
    double wind_speed = PLACE[name]!['wind_speed']!;
    double wave_height = PLACE[name]!['wave_height']!;
    double wave_frequency = PLACE[name]!['wave_frequency']!;
    String result = await serviceProvider.aiService.predict(latitude, longitude, wind_speed, wave_height, wave_frequency);
    return result;
  }

  @override
  Widget build(BuildContext context) {

    serviceProvider = context.read<ServiceProvider>();

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
            FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false || snapshot.hasError) {
                  return const CircularProgressIndicator();
                }
                String data = snapshot.data!;
                int predicted = int.parse(data.split(" ")[1]);
                data = data.split(" ")[0];

                return Container(
                  height: 240,
                  width: 320,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                        color: predicted > 1 ? Colors.blue : Colors.red,
                        width: 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat("yyyy.MM.dd").format(departure.date),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Text("위험도", style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),),
                          const SizedBox(width: 10,),
                          Text("$data", style: TextStyle(fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: predicted > 1 ? Colors.blue : Colors
                                  .red),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Text("날씨: 맑음", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),),
                      const Text("시계 제한: O(안개)", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),),
                      const Text("풍랑 및 폭풍해일 주의보: X", style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
