import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/models/CategoryModel.dart';
import 'package:sizzlr_customer_side/providers/authProvider.dart';
import 'package:sizzlr_customer_side/providers/canteenProvider.dart';
import 'package:sizzlr_customer_side/providers/viewCartLoaderProvider.dart';
import 'package:sizzlr_customer_side/screens/Home/components/components.dart';

import '../../providers/cartProvider.dart';
import '../Cart/components/CartComponents.dart';

class CategoryItemsScreen extends StatefulWidget {
  const CategoryItemsScreen({Key? key, required this.selectedCategory, }) : super(key: key);

  final CategoryModel selectedCategory;

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('${widget.selectedCategory.categoryName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
      body: Stack(
        children: [
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection('institutions/X9ydF3xqSTtwR2lBmcUN/canteens/${canteenFilterProvider
          //       .selectedCanteenId}/menu').snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return CircularProgressIndicator();
          //     }
          //     final items = snapshot.data!.docs;
          //     final itemsList = items.where((item) => item['category_id'] == widget.selectedCategory.categoryId).toList();
          //     if (itemsList.isEmpty) {
          //       return Center(child: Text('No items in category id: ${widget.selectedCategory.categoryId}'));
          //     }
          //     final itemCardList = [];
          //     return ListView(
          //       padding: EdgeInsets.symmetric(horizontal: 15),
          //       children: [],
          //     );
          //   }
          // ),

          Consumer<CanteenProvider>(builder: (context, canteenProvider, child) {
            final itemCardList = canteenProvider.menu.map((item) => ItemCard(menu: item,)).toList();
            if (context.watch<CanteenProvider>().isFetchingMenu) {
              return const Center(child: CircularProgressIndicator());
            } else if (itemCardList.isEmpty) {
              return Center(child: Text('No items in category id: ${widget.selectedCategory.categoryId}'));
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                children: itemCardList,
              );
            }
          }),

          context.watch<Cart>().cart.isEmpty
              ? Container()
              : CartSnackBar(),
        ],
      ),
    );
  }
}
