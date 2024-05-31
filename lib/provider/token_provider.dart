import 'package:flutter/material.dart';

import '../domain/member.dart';
import '../service/auth_service.dart';

class TokenProvider {

  String? token;
  Member? member;

  late final AuthService authService;

  TokenProvider({
    required this.token,
    required this.authService,
  });

  Future<void> signUp(String name, String username, String userPassword) async {
    await authService.signUp(name, username, userPassword);
  }

  Future<void> signIn(String username, String userPassword) async {
    token = await authService.signIn(username, userPassword);
    Map<String, dynamic> res = await authService.get(token!) as Map<String, dynamic>;
    member = Member.fromJson(res);
  }

  void signOut() {
    token = '';
  }
}