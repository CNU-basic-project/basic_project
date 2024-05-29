import 'package:basicfirebase/domain/departure.dart';
import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../domain/reservation.dart';

class ReservationService {

  Future<List<Reservation>> get(String token) async {
    Map response = await HttpService.get(token, "/reservations");
    List<Reservation> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      res.add(Reservation.fromJson(response['data'][i]));
    }
    return res;
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