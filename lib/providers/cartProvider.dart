import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  // TODO: Instead of int make a list (possibly of strings, which will contain item id (check once which will be more economical for number of reads... Just storing item id and then searching what item or item model??))
  int _cart = 0;

  int get cart => _cart;

  void addToCart() {
    _cart++;
    notifyListeners();
  }

  void removeFromCart() {
    _cart > 0 ? _cart-- : null;
    notifyListeners();
  }

  void discardCart() {
    _cart = 0;
    notifyListeners();
  }
}