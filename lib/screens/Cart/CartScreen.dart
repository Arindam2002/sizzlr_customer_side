import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/providers/authProvider.dart';
import 'package:sizzlr_customer_side/providers/canteenProvider.dart';
import 'package:sizzlr_customer_side/providers/couponProvider.dart';
import 'package:sizzlr_customer_side/screens/IntermediateScreens/WaitingForOrderConfirmation.dart';
import '../../providers/cartProvider.dart';
import '../Home/components/components.dart';
import 'components/CartComponents.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text(
            'Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                children: [
                  OrderingFromCanteen(
                      canteenName:
                          context.read<CanteenProvider>().selectedCanteenName),
                  context.watch<Coupon>().couponId.isNotEmpty
                      ? const TotalSavingsInOrderComponent(amountSaved: 30)
                      : Container(),
                  Consumer<Cart>(builder: (context, cartProvider, child) {
                    return OrdersSectionInCart(
                      cartItems: cartProvider.cart.values.map((item) => item[0]).toList(),
                    );
                  }),
                  const ApplyCouponComponent(),
                  const Header(title: 'Bill Details'),
                  BillComponent(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            CtaPayAmount(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                Map<String, dynamic> data = {
                  // 'order_id': newOrderRef.id,
                  'canteen_id': Provider.of<CanteenProvider>(context, listen: false).selectedCanteenId,
                  'ordered_by': Provider.of<AuthProvider>(context, listen: false).user?.uid,
                  'request_accepted': null,
                  'ask_a_friend': false,
                  'pick_up_by': "",
                  'coupon_applied': false,
                  'coupon_id': "",
                  'order_completed': false,
                  'is_prepared': false,
                  'delivered': false,
                  'items_ordered': Provider.of<Cart>(context, listen: false).currentCartItems,
                  'timestamp': FieldValue.serverTimestamp(),
                  'transaction_id': "",
                  'total_amount': Provider.of<Cart>(context, listen: false).sumTotalMrp + 6,
                  'expected_preparation_time_management': null,
                };
                context.read<Cart>().placeOrder(
                  Provider.of<CanteenProvider>(context, listen: false).selectedCanteenId,
                  '653656fb440dfeb068ea3832',
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WaitingForOrderConfirmationScreen()));
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
