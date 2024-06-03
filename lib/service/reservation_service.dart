import 'package:basicfirebase/domain/departure.dart';
import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../common/exception/reject_reservation_exception.dart';
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

  Future<void> add(String token, Departure departure) async {
    Map response = await HttpService.postAndGet(token, "/reservations",
        {
          'departureId' : departure.id,
        });
    if (response.containsKey('message')) {
      throw RejectReservationException(response['message']);
    }
  }

  Future<void> delete(String token, Reservation reservation) async {
    HttpService.delete(token, "/reservations/${reservation.id}");
  }
}