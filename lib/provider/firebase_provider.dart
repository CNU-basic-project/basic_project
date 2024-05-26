import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../repository/firebase_repository.dart';

class FirebaseProvider with ChangeNotifier {
  final FirebaseRepository firebaseRepository;

  FirebaseProvider({
    required this.firebaseRepository,
  }) {
    _initializeUser();
  }

  void _initializeUser() {
    firebaseRepository.initializeUser(render);
  }

  User? getUser() {
    return firebaseRepository.getUser();
  }

  void render() {
    notifyListeners();
  }

  Future<bool> signUp(String userName, String userEmail, String userPassword) {
    return firebaseRepository.signUp(userName, userEmail, userPassword, render);
  }

  Future<bool> signIn(String userEmail, String userPassword) {
    return firebaseRepository.signIn(userEmail, userPassword, render);
  }

  bool signOut() {
    return firebaseRepository.signOut(render);
  }
}