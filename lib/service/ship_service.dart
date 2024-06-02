import 'package:basicfirebase/service/http_service.dart';

import '../domain/ship.dart';

class ShipService {

  Future<void> add(String token, Ship ship) async {
    HttpService.post(token, "/ships", ship.toJson());
  }
  
  Future<List<Ship>> get(String token) async {
    Map response = await HttpService.get(token, "/ships");
    List<Ship> res = List.empty(growable: true);
    for (int i=0; i<response['size']; i++) {
      res.add(Ship.fromJson(response['data'][i]));
    }
    return res;
  }
  
  Future<void> update(String token, Ship ship) async {
    HttpService.put(token, "/ships/${ship.id}", ship.toJson());
  }

  Future<void> delete(String token, Ship ship) async {
    HttpService.delete(token, "/ships/${ship.id}");
  }
}