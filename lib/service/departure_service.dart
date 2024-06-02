import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../domain/departure.dart';
import '../domain/ship.dart';

class DepartureService {

  Future<List<Departure>> findAll() async {
    Map response = await HttpService.get("", "/departures");
    return _convert(response);
  }

  Future<List<Departure>> findAllByQuery(String keyword) async {
    Map response = await HttpService.get("", "/departures/search?keyword=$keyword");
    return _convert(response);
  }

  Future<List<Departure>> findAllByDate(DateTime date) async {
    String format = DateFormat("yyyy-MM-dd").format(date);
    Map response = await HttpService.get("", "/departures/date?date=$format");
    return _convert(response);
  }

  Future<List<Departure>> findAllByDateAndQuery(DateTime date, String keyword) async {
    String format = DateFormat("yyyy-MM-dd").format(date);
    Map response = await HttpService.get("", "/departures/query?date=$format&keyword=$keyword");
    return _convert(response);
  }

  Future<List<Departure>> findAllByShip(Ship ship) async {
    Map response = await HttpService.get("", "/departures/ship/${ship.id}");
    return _convert(response);
  }

  Future<void> add(String token, Departure departure) async {
    return HttpService.post(token, "/departures", departure.toJson());
  }

  Future<void> delete(String token, Departure departure) async {
    return HttpService.delete(token, "/departures/${departure.id}");
  }

  List<Departure> _convert(Map response) {
    List<Departure> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      res.add(Departure.fromJson(response['data'][i]));
    }
    return res;
  }
}