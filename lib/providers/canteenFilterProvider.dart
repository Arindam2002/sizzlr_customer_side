import 'package:flutter/material.dart';

class Filter with ChangeNotifier {
  int _value = 1;

  int get value => _value;

  void updateValue (int chipValue) {
    _value = chipValue;
    notifyListeners();
  }
}