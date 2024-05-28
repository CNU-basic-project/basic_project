import 'package:basicfirebase/service/http_service.dart';

import '../domain/ship.dart';

class ShipService {

  Future<Map> add(String token, Ship ship) async {
    Map response = await HttpService.post(token, "/ships", ship.toJson());
    return response;
  }
  
  Future<Map> get(String token) async {
    Map response = await HttpService.get(token, "/ships");
    return response;
  }
  
  Future<Map> update(String token, Ship ship) async {
    Map response = await HttpService.put(token, "/ships/${ship.id}", ship.toJson());
    return response;
  }
  
  Future<Map> delete(String token, Ship ship) async {
    Map response = await HttpService.delete(token, "/ships/${ship.id}");
    return response;
  }
}