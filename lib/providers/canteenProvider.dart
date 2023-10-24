import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizzlr_customer_side/constants/constants.dart';
import 'package:sizzlr_customer_side/models/CanteenModel.dart';
import 'package:sizzlr_customer_side/models/CategoryModel.dart';
import 'package:sizzlr_customer_side/models/MenuItemModel.dart';

class CanteenProvider with ChangeNotifier {
  int _value = 1;
  String _canteenId = '';
  String _canteenName = '';

  List<CanteenModel> _canteens = [];
  Map<String, List<CategoryModel>> _categoriesInCanteen = {};
  List<MenuItemModel> _menu = [];

  bool _isFetchingCategories = false;
  bool _isFetchingMenu = false;

  int get value => _value;
  String get selectedCanteenId => _canteenId;
  String get selectedCanteenName => _canteenName;

  List<CanteenModel> get canteens => _canteens;
  Map<String, List<CategoryModel>> get categoriesInCanteen => _categoriesInCanteen;
  List<MenuItemModel> get menu => _menu;

  bool get isFetchingMenu => _isFetchingMenu;
  bool get isFetchingCategories => _isFetchingCategories;

  void updateValue (int chipValue, String canteenId, String canteenName) {
    _value = chipValue;
    _canteenId = canteenId;
    _canteenName = canteenName;

    // if (kDebugMode) {
    //   print('Selected Canteen Id: $_canteenId (Printing from canteenProvider.dart)');
    // }

    notifyListeners();
  }

  Future<void> getCanteens () async {
    if (kDebugMode) {
      print('Get canteens called');
    }
    const String apiEndpoint = '$baseUrl/get-canteens';

    final Response response = await get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> canteens = jsonDecode(response.body)['data'];

      _canteens = canteens.map((canteen) => CanteenModel.fromJson(canteen)).toList();

    } else {
      throw Exception('Failed to load canteens ; status code = ${response.statusCode}; response = ${response.body}');
    }

    notifyListeners();
  }

  Future<void> getCategoriesInCanteen(String? canteenId) async {
    _isFetchingCategories = true;
    final String apiEndpoint = '$baseUrl/get-categories/$canteenId';

    final Response response = await get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body)['data'];

      if (!_categoriesInCanteen.containsKey(canteenId)) {
        _categoriesInCanteen[canteenId!] = [];
      }

      for (var categoryData in categories) {
        CategoryModel category = CategoryModel.fromJson(categoryData);
        _categoriesInCanteen[canteenId]?.add(category);
      }

    } else {
      throw Exception('Failed to load categories ; status code = ${response.statusCode}; response = ${response.body}');
    }
    _isFetchingCategories = false;

    notifyListeners();
  }

  // Fetch menu items in a category in a canteen
  Future<void> getMenuItemsInCategory(String? canteenId, String? categoryId) async {
    _isFetchingMenu = true;
    final String apiEndpoint = '$baseUrl/get-menu/$canteenId/$categoryId';

    final Response response = await get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      final List<dynamic> menuItems = jsonDecode(response.body)['data'];
      _menu = menuItems.map((menuItem) => MenuItemModel.fromJson(menuItem)).toList();


    } else {
      throw Exception('Failed to load categories ; status code = ${response.statusCode}; response = ${response.body}');
    }

    _isFetchingMenu = false;

    notifyListeners();
  }

  // Reset the value of the canteen provider
  void resetCanteenProvider () {
    _value = 1;
    _canteenId = '';
    _canteenName = '';
    _canteens = [];
    _categoriesInCanteen = {};
    _isFetchingCategories = false;
  }

  // Stream<List<Document>> getCanteens () {
  //   final db = Db(mongoUri);
  //   db.open();
  //
  //   final canteensCollection = db.collection('canteens');
  //
  //   final changeStream = canteensCollection.watch(keyFullDocument).map((event) => {
  //     if (event.operationType == OperationType.insert) {
  //       print('New canteen added: ${event.fullDocument}');
  //     }
  //   });
  // }

}