import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/screens/Home/components/components.dart';

import '../../providers/cartProvider.dart';
import '../Cart/components/CartComponents.dart';

class CategoryItemsScreen extends StatefulWidget {
  const CategoryItemsScreen({Key? key, required this.categoryName}) : super(key: key);

  final String categoryName;

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.categoryName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              for (int i = 0; i < 10; i++) ItemCard(dishName: 'dishName', quantity: '1 paratha', estTime: 10, price: 30, imageUrl: 'imageUrl'),
            ],
          ),
          context.watch<Cart>().cart == 0
              ? Container()
              : CartSnackBar(),
        ],
      ),
    );
  }
}
