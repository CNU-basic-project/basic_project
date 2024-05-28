import 'package:basicfirebase/service/http_service.dart';

import '../domain/reservation.dart';

class ReservationService {

  // TODO type
  void get(String token) {
    HttpService.get(token, "/reservations");
  }

  void add(String token, Reservation reservation) {
    HttpService.post(token, "/reservations", reservation.toJson());
  }

  void delete(String token, Reservation reservation) {
    HttpService.delete(token, "/reservations/${reservation.id}");
  }
}