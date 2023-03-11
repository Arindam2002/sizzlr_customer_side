import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/providers/authProvider.dart';
import 'package:sizzlr_customer_side/providers/canteenFilterProvider.dart';
import 'package:sizzlr_customer_side/providers/viewCartLoaderProvider.dart';
import 'package:sizzlr_customer_side/screens/Home/components/components.dart';

import '../../providers/cartProvider.dart';
import '../Cart/components/CartComponents.dart';

class CategoryItemsScreen extends StatefulWidget {
  const CategoryItemsScreen({Key? key, required this.categoryName, required this.categoryId}) : super(key: key);

  final String categoryName;
  final String categoryId;

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  Widget build(BuildContext context) {

    final canteenFilterProvider = Provider.of<CanteenFilter>(context);

    return ModalProgressHUD(
      inAsyncCall: context.watch<ViewCartLoader>().isLoading,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(widget.categoryName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens/${canteenFilterProvider
                  .selectedCanteenId}/menu').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final items = snapshot.data!.docs;
                final itemsList = items.where((item) => item['category_id'] == widget.categoryId).toList();
                if (itemsList.isEmpty) {
                  return Center(child: Text('No items in category id: ${widget.categoryId}'));
                }
                final itemCardList = itemsList.map((item) => ItemCard(dishName: item['name'], quantity: item['quantity'], estTime: item['preparation_time'], price: item['price'], imageUrl: 'imageUrl', itemId: item['item_id'],)).toList();
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  children: itemCardList,
                );
              }
            ),
            context.watch<Cart>().currentCartItems.isEmpty
                ? Container()
                : CartSnackBar(),
          ],
        ),
      ),
    );
  }
}
