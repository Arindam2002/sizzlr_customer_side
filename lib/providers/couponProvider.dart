import 'package:flutter/material.dart';

class Coupon with ChangeNotifier {
  // TODO: Instead of int make a list (possibly of strings, which will contain coupon id (check once which will be more economical for number of reads... Just storing coupon id and then searching what coupon or item model??))
  String _couponId = '';
  List<String> activeCouponsForCurrUser = ['coupon_id_1', 'coupon_id_2', 'coupon_id_3', 'coupon_id_4'];

  String get couponId => _couponId;

  void selectCoupon(String selectedCoupon) {
    _couponId = selectedCoupon;
    notifyListeners();
  }

  void removeCoupon() {
    _couponId = '';
    notifyListeners();
  }
}