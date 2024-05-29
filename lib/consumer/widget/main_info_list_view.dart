import 'dart:developer';

import 'package:basicfirebase/consumer/widget/main_info_card.dart';
import 'package:basicfirebase/provider/token_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/reservation.dart';
import '../../provider/notifier_provider.dart';
import '../../provider/service_provider.dart';

class ConsumerInfoListView extends StatelessWidget {
  ConsumerInfoListView({
    super.key,
    required this.reservations,
  });

  static const double HEIGHT = 200.0;

  final Future<List<Reservation>> reservations;

  late ServiceProvider serviceProvider;

  @override
  Widget build(BuildContext context) {

    serviceProvider = context.read<ServiceProvider>();

    return Consumer<NotifierProvider>(
        builder: (_, notifier, __) {
          return FutureBuilder(
              future: reservations,
              builder: (context, snapshot) {
                if (snapshot.hasData == false || snapshot.hasError) {
                  return const CircularProgressIndicator();
                }

                List<Reservation> reservations = snapshot.data!;
                List<Widget> children = List.empty(growable: true);

                children.add(ConsumerInfoCard(child: Image.asset("assets/info.png", width: 300,)));
                for (Reservation r in reservations) {
                  Image image = Image(image: serviceProvider.getImage(r.departure.ship.imagePath));
                  ConsumerInfoCard card = ConsumerInfoCard(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // 이미지에 동일한 테두리 적용
                      child: image,
                    ),
                  );
                  children.add(card);
                }

                return CarouselSlider(
                  options: CarouselOptions(
                      height: HEIGHT,
                      autoPlay: true
                  ),
                  items: children,
                );
              }
          );
        },
      );
  }
}