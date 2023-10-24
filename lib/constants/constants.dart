import 'dart:ui';

import 'package:flutter/material.dart';

Color kPrimaryGreen = const Color(0xFF27742D);
Color kPrimaryGreenLight = const Color(0xFF1fc385);
Color kPrimaryGreenAccent = const Color(0xFFF5FAF6);
Color kPrimaryGreenLightAccent = const Color(0xFFD0F6E5);
Color kRedColor = const Color(0xFFd50c11);
Color kPrimaryColor = const Color(0xFF6d49a7);
Color kPrimaryAccent = const Color(0xfff7f6fb);
Color kBlueColor = const Color(0xFF256EEE);
Color kBlueAccent = const Color(0xFFEDF3FF);

enum Role { customer, manager }

const String baseUrl = 'https://sizzlr-backend-v1-hymqs72joa-uc.a.run.app/api';
// const String mongoUri = 'mongodb://ac-q2w90nf-shard-00-00.i1w2lfj.mongodb.net:27017,ac-q2w90nf-shard-00-01.i1w2lfj.mongodb.net:27017,ac-q2w90nf-shard-00-02.i1w2lfj.mongodb.net:27017/?replicaSet=atlas-6kxl5t-shard-0';
const String mongoUri = 'mongodb+srv://sizzlr:Alohmora%4020@sizzlr-cluster-0.i1w2lfj.mongodb.net/?retryWrites=true&w=majority';

InputDecoration kFormFieldDecoration = const InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  labelStyle: TextStyle(color: Color(0xFF808080), fontSize: 12),
);

List<BoxShadow> kBoxShadowList = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 10,
    offset: const Offset(2, 2),
  ),
];