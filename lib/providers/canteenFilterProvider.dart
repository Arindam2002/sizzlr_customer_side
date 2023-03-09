import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CanteenFilter with ChangeNotifier {
  int _value = 1;
  String _canteenId = '';

  int get value => _value;
  String get selectedCanteenId => _canteenId;

  void updateValue (int chipValue, String canteenId) {
    _value = chipValue;
    _canteenId = canteenId;

    if (kDebugMode) {
      print('Selected Canteen Id: $_canteenId (Printing from canteenFilterProvider.dart)');
    }

    notifyListeners();
  }
}