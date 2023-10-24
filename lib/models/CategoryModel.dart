import 'package:flutter/cupertino.dart';

class CategoryModel {
  String? categoryId;
  String? categoryName;

  CategoryModel({
    @required this.categoryId,
    @required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['_id'],
      categoryName: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': categoryId,
    'name': categoryName,
  };
}