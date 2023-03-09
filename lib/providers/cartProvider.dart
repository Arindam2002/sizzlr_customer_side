import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, int> _cartMap = {};
  int _total = 0;

  Map<String, int> get currentCartItems => _cartMap;
  int get sumTotalMrp => _total;

  void addToCart(String itemId) {
    _cartMap[itemId] = (_cartMap[itemId] ?? 0) + 1;

    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartMap[itemId] = (_cartMap[itemId] ?? 0) - 1;
    if (_cartMap[itemId]! <= 0) {
      _cartMap.remove(itemId);
    }

    notifyListeners();
  }

  int? getItemQuantityInCart(String itemId) {
    return _cartMap.containsKey(itemId) ? _cartMap[itemId] : 0;
  }

  void discardCart() {
    _cartMap.clear();

    notifyListeners();
  }
}