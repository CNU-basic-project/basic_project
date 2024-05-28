import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class TokenProvider with ChangeNotifier {

  String? token;
  late final AuthService authService;

  TokenProvider({
    required this.token,
    required this.authService,
  });

  void setToken(String token) {
    this.token = token;
  }

  String? getToken() {
    return token;
  }

  Future<void> signUp(String name, String username, String userPassword) async {
    await authService.signUp(name, username, userPassword);
  }

  Future<void> signIn(String username, String userPassword) async {
    token = await authService.signIn(username, userPassword);
  }

  void signOut() {
    token = '';
  }
}