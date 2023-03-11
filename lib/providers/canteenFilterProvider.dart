import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CanteenFilter with ChangeNotifier {
  int _value = 1;
  String _canteenId = '';
  String _canteenName = '';

  int get value => _value;
  String get selectedCanteenId => _canteenId;
  String get selectedCanteenName => _canteenName;

  void updateValue (int chipValue, String canteenId, String canteenName) {
    _value = chipValue;
    _canteenId = canteenId;
    _canteenName = canteenName;

    if (kDebugMode) {
      print('Selected Canteen Id: $_canteenId (Printing from canteenFilterProvider.dart)');
    }

    notifyListeners();
  }
}