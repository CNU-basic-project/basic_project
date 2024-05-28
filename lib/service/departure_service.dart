import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../domain/departure.dart';

class DepartureService {

  Future<List<Departure>> findAll() async {
    Map response = await HttpService.get("", "/departures");
    List<Departure> res = List.empty(growable: true);
    return _convert(response);
  }

  Future<List<Departure>> findAllByQuery(String keyword) async {
    Map response = await HttpService.get("", "/departures/search?keyword=$keyword");
    List<Departure> res = List.empty(growable: true);
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

  void add(String token, Departure departure) async {
    HttpService.post(token, "/departures", departure.toJson());
  }

  List<Departure> _convert(Map response) {
    List<Departure> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      response['data'][i]['date'] = DateFormat("yyyy-MM-dd").parse(response['data'][i]['date']);
      response['data'][i]['arrivalTime'] = DateFormat("HH:mm:ss").parse(response['data'][i]['arrivalTime']);
      response['data'][i]['departureTime'] = DateFormat("HH:mm:ss").parse(response['data'][i]['departureTime']);
      res.add(Departure.fromJson(response['data'][i]));
    }
    return res;
  }
}