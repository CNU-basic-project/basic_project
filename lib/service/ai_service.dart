import 'package:basicfirebase/common/exception/ai_exception.dart';
import 'package:basicfirebase/service/http_service.dart';

class AIService {

  Future<String> predict(double latitude, double longitude, double wind_speed, double wave_height, double wave_frequency) async {
    Map response = await HttpService.postAndGet("", "/ai", {
      'latitude' : latitude,
      'longitude' : longitude,
      'wind_speed' : wind_speed,
      'wave_height' : wave_height,
      'wave_frequency' : wave_frequency
    });
    if (response.containsKey('message')) {
      throw AIException(response['message']);
    }
    return response['data']['result'];
  }
}