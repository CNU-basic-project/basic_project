import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../domain/departure.dart';

class DepartureService {

  Future<List<Departure>> findAll() async {
    Map response = await HttpService.get("", "/departures");
    List<Departure> res = List.empty(growable: true);
    print(response['size']);
    for (int i=0; i<response['size']; i++) {
      print("${response['data'][i]} 흠? 근데 왜 안됨?");
      try {
        res.add(Departure.fromJson(response['data'][i]));
      } catch (e) {
        print(e);
      }
    }
    return res;
  }

  Future<List<Departure>> findAllByQuery(String keyword) async {
    Map response = await HttpService.get("", "/departures/search?keyword=$keyword");
    List<Departure> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      res.add(Departure.fromJson(response['data'][i]));
    }
    return res;
  }

  Future<List<Departure>> findAllByDate(DateTime date) async {
    String format = DateFormat("yyyy-MM-dd").format(date);
    Map response = await HttpService.get("", "/departures/date?date=$format");
    List<Departure> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      res.add(Departure.fromJson(response['data'][i]));
    }
    return res;
  }

  Future<List<Departure>> findAllByDateAndQuery(DateTime date, String keyword) async {
    String format = DateFormat("yyyy-MM-dd").format(date);
    Map response = await HttpService.get("", "/departures/query?date=$format&keyword=$keyword");
    List<Departure> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      res.add(Departure.fromJson(response['data'][i]));
    }
    return res;
  }

  Future<Map> add(String token, Departure departure) async {
    Map response = await HttpService.post(token, "/departures", departure.toJson());
    return response;
  }
}