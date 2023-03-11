import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizzlr_customer_side/providers/canteenFilterProvider.dart';
import 'package:sizzlr_customer_side/screens/Cart/components/CartComponents.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  Map<String, int> _cartMap = {};
  int _total = 0;
  List<CartItem> _itemsWidgets = <CartItem>[];

  Map<String, int> get currentCartItems => _cartMap;
  int get sumTotalMrp => _total;
  List<CartItem> get cartItemWidgetList => _itemsWidgets;

  void addToCart(String itemId, int price) {
    _cartMap[itemId] = (_cartMap[itemId] ?? 0) + 1;
    _total = _total + price;

    notifyListeners();
  }

  void removeFromCart(String itemId, int price) {
    
    _cartMap[itemId] = (_cartMap[itemId] ?? 0) - 1;
    _total = _total - price;
    
    if (_cartMap[itemId]! <= 0) {
      _cartMap.remove(itemId);
      late CartItem b = const CartItem(itemName: '', servedQuantity: '', price: 0, veg: true, itemId: '');
      // for (var a in _itemsWidgets.where((element) => element.itemId == itemId)) {
      //   b = a;
      // }
      // _itemsWidgets.remove(b);
      _itemsWidgets.removeWhere((element) => element.itemId == itemId);
      print(_itemsWidgets);
    }

    notifyListeners();
  }

  int? getItemQuantityInCart(String itemId) {
    return _cartMap.containsKey(itemId) ? _cartMap[itemId] : 0;
  }

  void discardCart() {
    _cartMap.clear();
    _total = 0;
    _itemsWidgets.clear();

    notifyListeners();
  }

  Future<Map<String, dynamic>> getItemDetails(String itemId, String canteenId) async {
    final snapshot = await FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens/$canteenId/menu/').doc(itemId).get();
    return snapshot.data()!;
  }

  // A function to create a list of CartItemWidgets from a cartItems map
  Future<void> createCartItemsWidgets(Map<String, int> cartItems, String canteenId) async {
    // final itemsWidgets = <CartItem>[];
    for (final entry in cartItems.entries) {
      final itemId = entry.key;
      final quantity = entry.value;
      final itemDetails = await getItemDetails(itemId, canteenId);
      final itemWidget = CartItem(itemName: itemDetails['name'], servedQuantity: itemDetails['quantity'], price: itemDetails['price'], veg: itemDetails['is_veg'], itemId: itemDetails['item_id']);
      // CartItemWidget(
      //   name: itemDetails['name'],
      //   serving: itemDetails['standard_serving'],
      //   quantity: quantity,
      //   price: itemDetails['price'].toDouble(),
      // );
      if (!_itemsWidgets.contains(itemWidget)) {
        _itemsWidgets.add(itemWidget);
      }
    }

    notifyListeners();
  }

  Future<void> placeOrder(String canteenId, Map<String, dynamic> data) async {
    // add order to 'orders' collection for the canteen

    // Temporary code, not gonna go ahead with this shit --------------------------------------
    DocumentReference newOrderRef = FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens/$canteenId/orders(testing)').doc();

    data.addAll({
      'order_id': newOrderRef.id,
    });

    newOrderRef.set(data, SetOptions(merge: true));

    for (var entry in _cartMap.entries) {
      newOrderRef.collection('items').doc().set({
        'item_id': entry.key,
        'quantity_ordered': entry.value,
      });
    }


    // ----------------------------------------------------------------------------------------
  }

  void clearCartItemWidgetList() {
    _itemsWidgets.clear();
  }

  // Future<String> getCanteenName(String canteenId) async {
  //   DocumentSnapshot targetDoc = await FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens').doc(canteenId).get();
  //   return targetDoc.get('name');
  // }
}