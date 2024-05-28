import 'package:basicfirebase/domain/departure.dart';
import 'package:basicfirebase/service/http_service.dart';

import '../domain/reservation.dart';

class ReservationService {

  Future<Map> get(String token) async {
    Map response = await HttpService.get(token, "/reservations");
    return response;
  }

  void add(String token, Departure departure) {
    HttpService.post(token, "/reservations",
        {
          'departureId' : departure.id,
        });
  }

  void delete(String token, Reservation reservation) {
    HttpService.delete(token, "/reservations/${reservation.id}");
  }
}