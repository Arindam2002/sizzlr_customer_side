import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/models/MenuItemModel.dart';
import 'package:sizzlr_customer_side/providers/couponProvider.dart';
import 'package:sizzlr_customer_side/screens/Cart/CartScreen.dart';

import '../../../constants/constants.dart';
import '../../../providers/cartProvider.dart';

class CartSnackBar extends StatelessWidget {
  const CartSnackBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 0, top: 5, bottom: 5),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFf2f1f2)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<Cart>(builder: (context, cartProvider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You have ${cartProvider.cart.length} item${cartProvider.cart.length == 1 ? '' : 's'} in your cart',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Row(
                        children: [
                          Text(
                            '${cartProvider.sumTotalMrp}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            ' + convenience fee',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        // print(context.read<Cart>().cart);
                        // TODO: CREATE CART ITEMS WIDGETS
                        // await context.read<Cart>().createCartItemsWidgets(context.read<Cart>().currentCartItems, context.read<CanteenProvider>().selectedCanteenId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      height: 30,
                      minWidth: 60,
                      padding: EdgeInsets.zero,
                      color: kPrimaryGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'View',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 18,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content:
                                  const Text('Discard all items in your cart?'),
                                  contentPadding: const EdgeInsets.only(
                                      top: 20, left: 24, right: 24),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          context.read<Cart>().discardCart();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Discard'))
                                  ],
                                ));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrdersSectionInCart extends StatelessWidget {
  const OrdersSectionInCart({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  final List<dynamic> cartItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: kBoxShadowList,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: kPrimaryGreen, width: 4))),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Consumer<Cart>(builder: (context, cartProvider, child) {
              final items = cartProvider.cart.values.map((item) => CartItem(item: item[0])).toList();
              return ListView(
                shrinkWrap: true,
                children: items,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final MenuItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // VEG / NON-VEG
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.green,
                    ),
                  ),
                ),

                // ITEM NAME
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.itemName}',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Serves: ${item.servingQuantity}',
                          style: const TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE3E2E7)),
                  ),
                  child: Consumer<Cart>(builder: (context, cartProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            cartProvider.removeItemFromCart(item.itemId.toString(), item.price!);
                          },
                          borderRadius: BorderRadius.circular(40),
                          radius: 40,
                          splashColor: kPrimaryGreen.withAlpha(20),
                          child: Icon(
                            Icons.remove_rounded,
                            size: 16,
                            color: kPrimaryGreen,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            '${cartProvider.cart[item.itemId]![1]}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryGreen,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // context.read<Cart>().addToCart('$itemId', price!);
                            cartProvider.addItemToCart(item.itemId.toString(), item.price!, item);
                          },
                          borderRadius: BorderRadius.circular(40),
                          radius: 40,
                          splashColor: kPrimaryGreen.withAlpha(20),
                          child: Icon(
                            Icons.add_rounded,
                            size: 16,
                            color: kPrimaryGreen,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '₹${item.price}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TotalSavingsInOrderComponent extends StatelessWidget {
  const TotalSavingsInOrderComponent({
    Key? key,
    required this.amountSaved,
  }) : super(key: key);

  final int? amountSaved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryGreenLightAccent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: kBoxShadowList,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Text(
          'You saved ₹$amountSaved on this order!',
          style: TextStyle(color: kPrimaryGreen, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CouponChipComponent extends StatelessWidget {
  const CouponChipComponent({
    Key? key,
    required this.couponTitle,
    required this.couponSubtitle,
    required this.keyValue,
    required this.validTill,
  }) : super(key: key);

  final String? couponTitle;
  final String? couponSubtitle;
  final String? keyValue;
  final String? validTill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ChoiceChip(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.shade400,
        elevation: 0.5,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.discount_rounded, color: kBlueColor,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('$couponTitle', style: const TextStyle(fontWeight: FontWeight.bold), softWrap: true,),
                        Text('$couponSubtitle', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text('Valid till $validTill', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black54, fontStyle: FontStyle.italic),),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        labelStyle: const TextStyle(fontSize: 12),
        side: context.watch<Coupon>().couponId == keyValue ? BorderSide(color: kBlueColor) : BorderSide(color: Colors.grey.shade300),
        selectedColor: kBlueAccent,
        labelPadding: EdgeInsets.zero,
        selected: context.watch<Coupon>().couponId == keyValue,
        onSelected: (bool selected) {
          selected ? context.read<Coupon>().selectCoupon(keyValue!) : null;
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: kPrimaryGreen)),
      ),
    );
  }
}

class ApplyCouponComponent extends StatelessWidget {
  const ApplyCouponComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: kBoxShadowList,
        ),
        child: Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ListTileTheme(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 15),
            dense: true,
            horizontalTitleGap: 10,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            child: ExpansionTile(
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.discount_outlined,
                color: kBlueColor,
                size: 22,
              ),
              title: context.watch<Coupon>().couponId.isEmpty ? const Text(
                'Apply coupon',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ) : Text(
                'Coupon Applied!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBlueColor),
              ),
              childrenPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                context
                    .watch<Coupon>()
                    .activeCouponsForCurrUser
                    .isEmpty
                    ? Container(
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "You don't have any coupons :')\nComplete weekly tasks to unlock exciting coupons!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            // width: 100,
                            // color: Colors.grey,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              dragStartBehavior:
                              DragStartBehavior.down,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: const [
                                CouponChipComponent(
                                  couponTitle:
                                  '50% off total order',
                                  couponSubtitle: 'upto ₹50',
                                  keyValue: 'coupon_id_1',
                                  validTill: '01/01/2023',
                                ),
                                CouponChipComponent(
                                  couponTitle:
                                  '20% off total order',
                                  couponSubtitle: 'upto ₹10',
                                  keyValue: 'coupon_id_2',
                                  validTill: '01/01/2023',
                                ),
                                CouponChipComponent(
                                  couponTitle:
                                  '60% off total order',
                                  couponSubtitle: 'upto ₹20',
                                  keyValue: 'coupon_id_3',
                                  validTill: '01/01/2023',
                                ),
                                CouponChipComponent(
                                  couponTitle:
                                  '10% off total order',
                                  couponSubtitle: 'upto ₹10',
                                  keyValue: 'coupon_id_4',
                                  validTill: '01/01/2023',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    context.watch<Coupon>().couponId.isNotEmpty
                        ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius:
                          BorderRadius.circular(8),
                          splashColor: kBlueAccent,
                          onTap: () {
                            context
                                .read<Coupon>()
                                .removeCoupon();
                          },
                          child: Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Text(
                              'Remove coupon',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: kBlueColor,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                          )),
                    )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderingFromCanteen extends StatelessWidget {
  const OrderingFromCanteen({
    Key? key,
    required this.canteenName,
  }) : super(key: key);

  final String? canteenName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          const Text(
            'Ordering from ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            '$canteenName',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CtaPayAmount extends StatelessWidget {
  const CtaPayAmount({
    Key? key, required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                        fontSize: 12,
                        color: kPrimaryGreen,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${context.watch<Cart>().sumTotalMrp + 6}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor:
                    MaterialStateProperty.all(kPrimaryGreen)),
                onPressed: onPressed,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BillComponent extends StatelessWidget {
  BillComponent({
    Key? key,
  }) : super(key: key);

  int convenienceFee = 6;

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cartProvider, child) {
        return Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: kBoxShadowList
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Item Total', style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),),
                    Text('₹${cartProvider
                        .sumTotalMrp}', style: const TextStyle(fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF444547)),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Convenience fee', style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),),
                    Text('+ ₹$convenienceFee', style: const TextStyle(fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF444547)),),
                  ],
                ),
              ),
              context
                  .watch<Coupon>()
                  .couponId
                  .isNotEmpty ? Column(
                children: [
                  DottedLine(
                    direction: Axis.horizontal,
                    dashColor: Colors.black54.withAlpha(60),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item Discount', style: TextStyle(fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),),
                        Text('- ₹30', style: TextStyle(fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1ca672)),),
                      ],
                    ),
                  )
                ],
              ) : Container(),
              Column(
                children: [
                  DottedLine(
                    direction: Axis.horizontal,
                    dashColor: Colors.black54.withAlpha(60),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('To Pay',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight
                              .bold, color: Colors.black),),
                        Text('₹${cartProvider
                            .sumTotalMrp + convenienceFee}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight
                              .bold, color: Colors.black),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}