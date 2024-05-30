import 'package:basicfirebase/service/http_service.dart';

import '../domain/ship.dart';

class ShipService {

  void add(String token, Ship ship) {
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
  
  void update(String token, Ship ship) {
    HttpService.put(token, "/ships/${ship.id}", ship.toJson());
  }

  void delete(String token, Ship ship) {
    HttpService.delete(token, "/ships/${ship.id}");
  }
}