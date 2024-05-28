import 'package:basicfirebase/service/http_service.dart';

import '../domain/ship.dart';

class ShipService {

  // TODO type
  void add(String token, Ship ship) {
    HttpService.post(token, "/ships", ship.toJson());
  }
  
  void get(String token) {
    HttpService.get(token, "/ships");
  }
  
  void update(String token, Ship ship) {
    HttpService.put(token, "/ships/${ship.id}", ship.toJson());
  }
  
  void delete(String token, Ship ship) {
    HttpService.delete(token, "/ships/${ship.id}");
  }
}