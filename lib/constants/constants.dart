import 'dart:ui';

import 'package:flutter/material.dart';

Color kPrimaryGreen = Color(0xFF27742D);
Color kPrimaryGreenLight = Color(0xFF1fc385);
Color kPrimaryGreenAccent = Color(0xFFF5FAF6);
Color kPrimaryGreenLightAccent = Color(0xFFD0F6E5);
Color kRedColor = Color(0xFFd50c11);
Color kPrimaryColor = Color(0xFF6d49a7);
Color kPrimaryAccent = Color(0xfff7f6fb);
Color kBlueColor = Color(0xFF256EEE);
Color kBlueAccent = Color(0xFFEDF3FF);

InputDecoration kFormFieldDecoration = InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  labelStyle: TextStyle(color: Color(0xFF808080), fontSize: 12),
);

List<BoxShadow> kBoxShadowList = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 10,
    offset: Offset(2, 2),
  ),
];