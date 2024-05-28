import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../domain/departure.dart';

class DepartureService {

  Future<Map> findAll() async {
    Map response = await HttpService.get("", "/departures");
    return response;
  }

  Future<Map> findAllByQuery(String keyword) async {
    Map response = await HttpService.get("", "/departures/search?keyword=$keyword");
    return response;
  }

  Future<Map> findAllByDate(DateTime date) async {
    String format = DateFormat("yyyy-MM-dd").format(date);
    Map response = await HttpService.get("", "/departures/date?date=$format");
    return response;
  }

  Future<Map> findAllByDateAndQuery(DateTime date, String keyword) async {
    String format = DateFormat("yyyy-MM-dd").format(date);
    Map response = await HttpService.get("", "/departures/query?date=$format&keyword=$keyword");
    return response;
  }

  Future<Map> add(String token, Departure departure) async {
    Map response = await HttpService.post(token, "/departures", departure.toJson());
    return response;
  }
}