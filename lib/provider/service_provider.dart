import 'package:flutter/material.dart';

import '../service/ai_service.dart';
import '../service/auth_service.dart';
import '../service/departure_service.dart';
import '../service/reservation_service.dart';
import '../service/ship_service.dart';

class ServiceProvider {

  late final AuthService authService;
  late final DepartureService departureService;
  late final ReservationService reservationService;
  late final ShipService shipService;
  late final AIService aiService;

  ServiceProvider({
    required this.authService,
    required this.departureService,
    required this.reservationService,
    required this.shipService,
    required this.aiService,
  });

  ImageProvider<Object> getImage(String? imagePath) {
    if (imagePath != null && imagePath.length > 10) {
      return NetworkImage(imagePath);
    }
    return const AssetImage('assets/ship.jpg');
  }
}