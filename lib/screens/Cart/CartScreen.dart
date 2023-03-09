import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/providers/couponProvider.dart';
import '../Home/components/components.dart';
import 'components/CartComponents.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              children: [
                OrderingFromCanteen(canteenName: 'H1 canteen'),
                context.watch<Coupon>().couponId.isNotEmpty
                    ? TotalSavingsInOrderComponent(amountSaved: 30)
                    : Container(),
                OrdersSectionInCart(
                  cartItems: [
                    CartItem(
                        itemName: 'Aloo Cheese Sandwich',
                        servedQuantity: '4 triangles',
                        price: 45,
                        veg: true, itemId: '',),
                    CartItem(
                        itemName: 'Peri Peri Maggi',
                        servedQuantity: '1 Pack',
                        price: 60,
                        veg: true, itemId: '',),
                  ],
                ),
                ApplyCouponComponent(),
                Header(title: 'Bill Details'),
                BillComponent(),
                SizedBox(height: 10,),
              ],
            ),
          ),
          CtaPayAmount(),
        ],
      ),
    );
  }
}

