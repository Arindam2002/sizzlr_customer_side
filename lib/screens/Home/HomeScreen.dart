import 'dart:ui';
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            // TODO: Convert to ListView.builder() and get canteens from backend
            children: [
              SizedBox(
                height: 50,
                child: ListView(
                  dragStartBehavior: DragStartBehavior.down,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    CanteenChipComponent(text: 'H1 Canteen', keyValue: 0),
                    CanteenChipComponent(text: 'H3 Canteen', keyValue: 1),
                    CanteenChipComponent(text: 'H4 Canteen', keyValue: 2),
                    CanteenChipComponent(text: 'Nescafe', keyValue: 3),
                    CanteenChipComponent(text: 'Hexagon', keyValue: 4),
                  ],
                ),
              ),
              Header(title: 'Watchya feel like having?'),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: GridView.builder(
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
                ),
              ),
              Header(title: 'Order Again!'),
              Container(
                height: 310,
                // color: Colors.black54,
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    for (int i = 0; i < 6; i++) HeightRectangularItemCard(),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        context.watch<Cart>().cart == 0
            ? Container()
            : CartSnackBar(),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryItemsScreen(categoryName: '$categoryName'),
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
