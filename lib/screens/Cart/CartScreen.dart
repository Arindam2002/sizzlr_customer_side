import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/providers/canteenFilterProvider.dart';
import 'package:sizzlr_customer_side/providers/couponProvider.dart';
import '../../providers/cartProvider.dart';
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
    return WillPopScope(
      onWillPop: () async {
        context.read<Cart>().clearCartItemWidgetList();
        return true;
      },
      child: Scaffold(
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
                  OrderingFromCanteen(canteenName: context.read<CanteenFilter>().selectedCanteenName),
                  context.watch<Coupon>().couponId.isNotEmpty
                      ? TotalSavingsInOrderComponent(amountSaved: 30)
                      : Container(),
                  Consumer<Cart>(
                    builder: (context, cartProvider, child) {
                      return OrdersSectionInCart(
                        cartItems: cartProvider.cartItemWidgetList,
                      );
                    }
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
      ),
    );
  }
}