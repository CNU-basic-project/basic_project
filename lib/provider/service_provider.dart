import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../service/departure_service.dart';
import '../service/reservation_service.dart';
import '../service/ship_service.dart';

class ServiceProvider with ChangeNotifier {

  late final AuthService authService;
  late final DepartureService departureService;
  late final ReservationService reservationService;
  late final ShipService shipService;

  ServiceProvider({
    required this.authService,
    required this.departureService,
    required this.reservationService,
    required this.shipService
  });
}