import 'package:flutter/material.dart';

class ViewCartLoader with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoader() {
    _isLoading = false;
    notifyListeners();
  }
}