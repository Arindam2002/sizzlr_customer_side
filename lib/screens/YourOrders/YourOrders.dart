import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../Cart/components/CartComponents.dart';
import 'components/components.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Your orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          MyOrderCard(),
        ],
      ),
    );
  }
}
