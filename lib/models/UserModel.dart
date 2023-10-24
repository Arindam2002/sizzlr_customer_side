import 'package:flutter/material.dart';
import '../constants/constants.dart';

class UserModel {
  final String? userId;
  final String? name;
  final String? email;
  final String? contact;
  final Role? role;

  UserModel({
    @required this.userId,
    @required this.name,
    @required this.email,
    @required this.contact,
    @required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'name': name,
      'email': email,
      'contact': contact,
      'role': role,
    };
  }
}