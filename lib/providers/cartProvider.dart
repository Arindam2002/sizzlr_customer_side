import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sizzlr_customer_side/models/MenuItemModel.dart';
import '../constants/constants.dart';

class Cart with ChangeNotifier {
  final Map<String, int> _cartMap = {};
  int _total = 0;
  final Map<String, List> _cart = {};

  Map<String, int> get currentCartItems => _cartMap;
  int get sumTotalMrp => _total;
  Map<String, List> get cart => _cart;

  void addItemToCart(String itemId, int price, MenuItemModel item) {
    _total = _total + price;

    if (!_cart.containsKey(itemId)) {
      _cart[itemId] = [item, 1];
    } else {
      _cart[itemId]![1] = _cart[itemId]![1] + 1;
    }
    print(_cart);
    notifyListeners();
  }

  void removeItemFromCart(String itemId, int price) {
    _total = _total - price;

    _cart[itemId]![1] = _cart[itemId]![1] - 1;
    if (_cart[itemId]![1] <= 0) {
      _cart.remove(itemId);
    }

    notifyListeners();
  }

  void discardCart() {
    _total = 0;
    _cart.clear();

    notifyListeners();
  }

  // Place order to the canteen
  Future<void> placeOrder(String customerId, String canteenId) async {
    const String apiEndpoint = '$baseUrl/place-order';

    List<Map<String, dynamic>> items = _cart.entries.map((e) => {
      'item_id': e.key,
      'quantity': e.value[1],
      'amount': e.value[0].price,
    }).toList();
    print(items);

    final Map<String, dynamic> body = {
      'customerId': customerId,
      'canteenId': canteenId,
      'items': items,
    };

    final Response response = await post(
      Uri.parse(apiEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('Order placed successfully');
      }
      discardCart();
    } else {
      if (kDebugMode) {
        print('Order placement failed');
      }
    }
  }
}

// Future<Map<String, dynamic>> getItemDetails(String itemId, String canteenId) async {
//   final snapshot = await FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens/$canteenId/menu/').doc(itemId).get();
//   return snapshot.data()!;
// }

// Future<void> placeOrder(String canteenId, Map<String, dynamic> data) async {
//   // add order to 'orders' collection for the canteen
//
//   // Temporary code, not gonna go ahead with this shit --------------------------------------
//   DocumentReference newOrderRef = FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens/$canteenId/orders(testing)').doc();
//
//   data.addAll({
//     'order_id': newOrderRef.id,
//   });
//
//   newOrderRef.set(data, SetOptions(merge: true));
//
//   for (var entry in _cartMap.entries) {
//     newOrderRef.collection('items').doc().set({
//       'item_id': entry.key,
//       'quantity_ordered': entry.value,
//     });
//   }
//
// }
