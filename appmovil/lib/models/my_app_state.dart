// my_app_state.dart
import 'package:flutter/material.dart';
import 'user_model.dart';


class MyAppState extends ChangeNotifier {
  String result = "";
  List<User> users = [];

  void setResult(String newResult) {
    result = newResult;
    notifyListeners();
  }

  void addUser(User user) {
    users.add(user);
    notifyListeners();
  }
}
