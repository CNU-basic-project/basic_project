import 'package:basicfirebase/service/http_service.dart';
import 'package:intl/intl.dart';

import '../domain/departure.dart';

class DepartureService {

  // TODO type
  void findAll() {
    HttpService.get("", "/departures");
  }

  void findAllByQuery(String keyword) {
    HttpService.get("", "/departures/search?keyword=$keyword");
  }

  void findAllByDate(DateTime date) {
    String format = DateFormat("yyyy-MM-dd").format(date);
    HttpService.get("", "/departures/date?date=$format");
  }

  void findAllByDateAndQuery(DateTime date, String keyword) {
    String format = DateFormat("yyyy-MM-dd").format(date);
    HttpService.get("", "/departures/query?date=$format&keyword=$keyword");
  }

  void add(String token, Departure departure) {
    HttpService.post(token, "/departures", departure.toJson());
  }
}