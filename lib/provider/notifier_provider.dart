import 'package:flutter/material.dart';

class NotifierProvider with ChangeNotifier {

  void render() {
    notifyListeners();
  }
}