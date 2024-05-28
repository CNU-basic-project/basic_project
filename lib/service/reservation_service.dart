import 'package:basicfirebase/service/http_service.dart';

import '../domain/reservation.dart';

class ReservationService {

  Future<Map> get(String token) async {
    Map response = await HttpService.get(token, "/reservations");
    return response;
  }

  Future<Map> add(String token, Reservation reservation) async {
    Map response = await HttpService.post(token, "/reservations", reservation.toJson());
    return response;
  }

  Future<Map> delete(String token, Reservation reservation) async {
    Map response = await HttpService.delete(token, "/reservations/${reservation.id}");
    return response;
  }
}