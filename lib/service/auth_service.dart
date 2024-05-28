import 'package:basicfirebase/service/http_service.dart';

class AuthService {

  Future<void> signUp(String name, String username, String userPassword) async {
    await HttpService.post("", "/members",
        {
          'username' : username,
          'password' : userPassword,
          'name' : name,
        }
    );
  }

  Future<String> signIn(String username, String userPassword) async {
    Map response = await HttpService.post("", "/members/login",
        {
          'username' : username,
          'password' : userPassword,
        }
    );
    return response['accessToken'];
  }

  Future<Map> get(String token) async {
    Map response = await HttpService.get(token, "/members/token");
    return response;
  }
}