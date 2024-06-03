import 'package:basicfirebase/service/http_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../domain/ship.dart';

class ShipService {

  Future<String> add(String token, Ship ship) async {
    Map response = await HttpService.postAndGet(token, "/ships", ship.toJson());
    return response['location'];
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

  Future<void> putFile(XFile file, String shipId) async {
    HttpService.uploadFile(file, "/ship$shipId${p.extension(file.path)}", "ship$shipId${p.extension(file.path)}");
  }
}