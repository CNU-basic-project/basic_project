import 'package:basicfirebase/service/http_service.dart';

import '../domain/ship.dart';

class ShipService {

  void add(String token, Ship ship) {
    HttpService.post(token, "/ships", ship.toJson());
  }
  
  Future<Map> get(String token) async {
    Map response = await HttpService.get(token, "/ships");
    return response;
  }
  
  void update(String token, Ship ship) {
    HttpService.put(token, "/ships/${ship.id}", ship.toJson());
  }

  void delete(String token, Ship ship) {
    HttpService.delete(token, "/ships/${ship.id}");
  }
}