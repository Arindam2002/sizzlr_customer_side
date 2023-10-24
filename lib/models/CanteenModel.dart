import 'package:flutter/material.dart';
import 'package:sizzlr_customer_side/models/MenuItemModel.dart';

class CanteenModel {
  final String? canteenId;
  final String? name;
  final String? manager;
  final String? contact;
  final bool? isActive;
  // final ORDERS? orders;
  final List<MenuItemModel>? menu;
  // final String? createdAt;
  // final String? updatedAt;

  CanteenModel({
    @required this.canteenId,
    @required this.name,
    @required this.manager,
    @required this.contact,
    @required this.isActive,
    @required this.menu,
    // this.orders,

    // this.createdAt,
    // this.updatedAt,
  });

  factory CanteenModel.fromJson(Map<String, dynamic> json) {
    return CanteenModel(
      canteenId: json['_id'].toString(),
      name: json['name'],
      manager: json['manager'],
      contact: json['contact'],
      isActive: json['isActive'],
      menu: json['menu'].map<MenuItemModel>((item) => MenuItemModel.fromJson(item)).toList(),
      // orders: json['orders'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': canteenId,
      'name': name,
      'manager': manager,
      'contact': contact,
      'isActive': isActive,
      'menu': menu,
      // 'orders': orders,
      // 'createdAt': createdAt,
      // 'updatedAt': updatedAt,
    };
  }
}