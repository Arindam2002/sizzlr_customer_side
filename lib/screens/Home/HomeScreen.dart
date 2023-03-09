import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/providers/canteenFilterProvider.dart';
import 'package:sizzlr_customer_side/providers/cartProvider.dart';
import 'package:sizzlr_customer_side/screens/CategoryItems/CategoryItemsScreen.dart';
import '../../constants/constants.dart';
import '../Cart/components/CartComponents.dart';
import 'components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final CollectionReference institutes = FirebaseFirestore.instance.collection('Institutes');

  void bleh() async {
    // print(institutes.doc().set({
    //   'name': 'name',
    //   'email': '_auth.currentUser?.email',
    //   'address': 'address',
    //   'mobile number': 'phoneNumber',
    //   'uid': '_auth.currentUser?.uid',
    //   'password': 'password',
    //   'tag': 'CLIENT',
    // }));
    institutes.where('institute_id', isEqualTo: 'vnXWKG5bgQYrRl1bTEeQ');
  }
  
  @override
  Widget build(BuildContext context) {
    bleh();
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
              // TODO: Convert to ListView.builder() and get canteens from backend
              children: [
                SizedBox(
                  height: 50,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection(
                          'institutions')
                          .doc('X9ydF3xqSTtwR2lBmcUN')
                          .collection('canteens')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Text('Loading canteens...', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.black54),));
                        }
                        final canteens = snapshot.data!.docs;
                        final canteensList = canteens.map((canteen) =>
                            CanteenChipComponent(text: canteen['name'],
                                keyValue: canteen['canteen_id'].hashCode, canteenId: canteen['canteen_id'],))
                            .toList();
                        return ListView(
                          dragStartBehavior: DragStartBehavior.down,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: canteensList,
                        );
                      }
                  ),
                ),
                Header(title: 'Watchya feel like having?'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: /*GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryItem(
                        categoryName: 'Snacks',
                      );
                    },
                  ),*/
                  StreamBuilder<QuerySnapshot>(
                    // stream: FirebaseFirestore.instance.collection('institutions').doc('X9ydF3xqSTtwR2lBmcUN').collection('canteens').doc(Provider.of<CanteenFilter>(context, listen: false).selectedCanteenId),
                    stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        // return Text('Unable to fetch categories at the moment!', style: TextStyle(color: Colors.red),);
                        return CircularProgressIndicator();
                      }
                      final categories = snapshot.data!.docs;
                      final categoryList = categories.map((category) => CategoryItem(categoryName: category['name'], categoryId: category['category_id'],)).toList();
                      return Wrap(
                        runSpacing: 20,
                        children: categoryList,
                      );
                    },
                  )
                ),
                Header(title: 'Order Again!'),
                // Container(
                //   height: 310,
                //   // color: Colors.black54,
                //   child: ListView(
                //     padding: const EdgeInsets.symmetric(vertical: 5),
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     children: [
                //       for (int i = 0; i < 6; i++) HeightRectangularItemCard(),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          context.watch<Cart>().currentCartItems.isEmpty
              ? Container()
              : CartSnackBar(),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categoryName, required this.categoryId,
  }) : super(key: key);

  final String? categoryName;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryItemsScreen(categoryName: '$categoryName', categoryId: '$categoryId',),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              'assets/images/fries.jpg',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: 120,
              child: ClipRRect(
                child: Text(
                  '$categoryName',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      height: 1.2),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
