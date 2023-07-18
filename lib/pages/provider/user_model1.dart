import 'package:flutter/material.dart';

class UserModel1 with ChangeNotifier {
  String name = "Kwok";

  void changeName() {
    name = "hello";
    notifyListeners();
  }
}
