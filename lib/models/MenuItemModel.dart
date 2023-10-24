import 'package:flutter/material.dart';

class MenuItemModel {
  String? itemId;
  String? itemName;
  String? servingQuantity;
  int? price;
  String? imageUrl;
  bool? isAvailable;
  bool? isVeg;
  int? preparationTime;

  MenuItemModel({
    @required this.itemId,
    @required this.itemName,
    @required this.servingQuantity,
    @required this.price,
    @required this.imageUrl,
    @required this.isAvailable,
    @required this.isVeg,
    @required this.preparationTime,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      itemId: json['_id'].toString(),
      itemName: json['name'],
      servingQuantity: json['serving_quantity'],
      price: json['price'],
      imageUrl: json['image_url'],
      isAvailable: json['availability'],
      isVeg: json['veg'],
      preparationTime: json['estimated_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': itemId,
      'name': itemName,
      'serving_quantity': servingQuantity,
      'price': price,
      'image_url': imageUrl,
      'availability': isAvailable,
      'veg': isVeg,
      'estimated_time': preparationTime,
    };
  }
}