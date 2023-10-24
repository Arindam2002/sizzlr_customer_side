import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/models/CanteenModel.dart';
import 'package:sizzlr_customer_side/providers/canteenProvider.dart';
import 'package:sizzlr_customer_side/providers/cartProvider.dart';
import 'package:sizzlr_customer_side/screens/CategoryItems/CategoryItemsScreen.dart';
import '../../constants/constants.dart';
import '../../providers/viewCartLoaderProvider.dart';
import '../Cart/components/CartComponents.dart';
import 'components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final CollectionReference institutes = FirebaseFirestore.instance.collection('Institutes');

  @override
  Widget build(BuildContext context) {
    // context.read<Cart>().cartItems.forEach((key, value) {print('Cart: ${key.itemName}: $value');});

    return ModalProgressHUD(
      inAsyncCall: context.watch<ViewCartLoader>().isLoading,
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListView(
                // TODO: Convert to ListView.builder() and get canteens from backend
                children: [
                  // // Firebase Stuff
                  // SizedBox(
                  //   height: 50,
                  //   child: StreamBuilder<QuerySnapshot>(
                  //       stream: FirebaseFirestore.instance.collection(
                  //           'institutions')
                  //           .doc('X9ydF3xqSTtwR2lBmcUN')
                  //           .collection('canteens')
                  //           .snapshots(),
                  //       builder: (context, snapshot) {
                  //         if (!snapshot.hasData) {
                  //           return Center(child: Text('Loading canteens...', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.black54),));
                  //         }
                  //         final canteens = snapshot.data!.docs;
                  //         final canteensList = canteens.map((canteen) =>
                  //             CanteenChipComponent(text: canteen['name'],
                  //                 keyValue: canteen['canteen_id'].hashCode, canteenId: canteen['canteen_id'], canteenName: canteen['name'],))
                  //             .toList();
                  //         return ListView(
                  //           dragStartBehavior: DragStartBehavior.down,
                  //           scrollDirection: Axis.horizontal,
                  //           shrinkWrap: true,
                  //           children: canteensList,
                  //         );
                  //       }
                  //   ),
                  // ),

                  SizedBox(
                    height: 50,
                    child: Consumer<CanteenProvider>(builder: (context, canteenProvider, child) {
                      // if (canteenProvider.canteens.isNotEmpty) {
                      //   CanteenModel firstCanteen = canteenProvider.canteens.first;
                      //   context.read<CanteenProvider>().updateValue(firstCanteen.canteenId.hashCode, firstCanteen.canteenId!, firstCanteen.name!);
                      // }
                      final canteensList = canteenProvider.canteens.map((canteen) =>
                          CanteenChipComponent(text: canteen.name,
                            keyValue: canteen.canteenId.hashCode,
                            canteenId: canteen.canteenId,
                            canteenName: '${canteen.name}',
                          ),
                      ).toList();
                      return canteenProvider.canteens.isNotEmpty ? ListView(
                        dragStartBehavior: DragStartBehavior.down,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: canteensList,
                      ) : Center(child: Text('Loading canteens...', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.black54),));
                    },),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Header(title: 'Watchya feel like having?'),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child:
                    Consumer<CanteenProvider>(builder: (context, canteenProvider, child) {
                      String selectedCanteen = canteenProvider.selectedCanteenId;

                      if (selectedCanteen == '') {
                        return const Center(child: Text('Please Select a canteen'));
                      } else if (!canteenProvider.categoriesInCanteen.containsKey(selectedCanteen)) {
                        canteenProvider.getCategoriesInCanteen(selectedCanteen);
                      }

                      if (canteenProvider.isFetchingCategories) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (canteenProvider.categoriesInCanteen[selectedCanteen] == null) {
                        return const Center(child: Text('Failed to load categories'));
                      } else if (canteenProvider.categoriesInCanteen[selectedCanteen]!.isEmpty) {
                        return const Center(child: Text('No categories in this canteen'));
                      } else {
                        final categoryList = canteenProvider.categoriesInCanteen[selectedCanteen]!
                            .map((category) => CategoryItem(
                          category: category,
                          canteenId: selectedCanteen,
                        ))
                            .toList();
                        return Wrap(
                          runSpacing: 20,
                          children: categoryList,
                        );
                      }
                    })
                  ),

                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
            context.watch<Cart>().cart.isEmpty
                ? Container()
                : const CartSnackBar(),
          ],
        ),
      ),
    );
  }
}

