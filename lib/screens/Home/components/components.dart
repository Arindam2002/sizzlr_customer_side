
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/models/CategoryModel.dart';
import 'package:sizzlr_customer_side/models/MenuItemModel.dart';
import '../../../constants/constants.dart';
import '../../../providers/canteenProvider.dart';
import '../../../providers/cartProvider.dart';
import '../../CategoryItems/CategoryItemsScreen.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({Key? key}) : super(key: key);

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late String dishName;
  late String quantity;
  late String estTime;
  late String price;

  File? image;

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 0),
      titlePadding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: const Text('Add item'),
      content: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                autofocus: true,
                onChanged: (val) {
                  dishName = val;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Name', hintText: 'Ex. Aloo Paratha')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                autofocus: true,
                onChanged: (val) {
                  quantity = val;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Quantity', hintText: 'Ex. 1 paratha')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                autofocus: true,
                onChanged: (val) {
                  estTime = val;
                },
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Estimated time (in minutes)',
                    hintText: 'Ex. 10 min')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                autofocus: true,
                onChanged: (val) {
                  price = val;
                },
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Price', hintText: 'Ex. 15')),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                      ),
                      child: image?.path == null
                          ? const Icon(
                              Icons.image_outlined,
                              color: Colors.grey,
                            )
                          : Image.file(
                              File(
                                image!.path,
                              ),
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Add Image',
                      ),
                    ),
                  ],
                ),
                // style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all(kPrimaryColor)),
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Add'),
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class EditItemDialog extends StatefulWidget {
  const EditItemDialog(
      {Key? key,
      required this.dishName,
      required this.quantity,
      required this.estTime,
      required this.price,
      required this.imageUrl})
      : super(key: key);

  final String? dishName;
  final String? quantity;
  final int? estTime;
  final int? price;
  final String? imageUrl;

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late String dishName;
  late String quantity;
  late String estTime;
  late String price;

  File? image;

  Future pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 0),
      titlePadding: const EdgeInsets.only(left: 0, right: 0, bottom: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: const Text('Edit item'),
      content: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                initialValue: '${widget.dishName}',
                autofocus: true,
                onChanged: (val) {
                  dishName = val;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Name', hintText: 'Ex. Aloo Paratha')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                initialValue: '${widget.quantity}',
                autofocus: true,
                onChanged: (val) {
                  quantity = val;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Quantity', hintText: 'Ex. 1 paratha')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                initialValue: '${widget.estTime}',
                autofocus: true,
                onChanged: (val) {
                  estTime = val;
                },
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Estimated time (in minutes)',
                    hintText: 'Ex. 10 min')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
                initialValue: '${widget.price}',
                autofocus: true,
                onChanged: (val) {
                  price = val;
                },
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 12),
                decoration: kFormFieldDecoration.copyWith(
                    labelText: 'Price', hintText: 'Ex. 15')),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                      ),
                      child: image?.path == null
                          ? const Icon(
                              Icons.image_outlined,
                              color: Colors.grey,
                            )
                          : Image.file(
                              //TODO: Use imageUrl here
                              File(
                                image!.path,
                              ),
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage(context);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Add Image',
                      ),
                    ),
                  ],
                ),
                // style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all(kPrimaryColor)),
              )
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Add'),
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class HeightRectangularItemCard extends StatefulWidget {
  const HeightRectangularItemCard({
    Key? key,
  }) : super(key: key);

  @override
  State<HeightRectangularItemCard> createState() =>
      _HeightRectangularItemCardState();
}

class _HeightRectangularItemCardState extends State<HeightRectangularItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: 180,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Card(
            surfaceTintColor: Colors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IMAGE
                    Row(
                      children: [
                        Expanded(
                            child: Image.asset(
                          'assets/images/fries.jpg',
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                      ],
                    ),
                    // PRODUCT INFO
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10, top: 5),
                      child: Wrap(
                        children: [
                          Text(
                            'Peri Peri Fries',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                size: 18,
                                color: Colors.black54,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  '15 min',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text(
                                '₹ 80',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: context.watch<Cart>().cart.isEmpty
                            ? OutlinedButton(
                                style: ButtonStyle(
                                    surfaceTintColor: MaterialStateProperty.all(
                                        kPrimaryGreen),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        kPrimaryGreen.withAlpha(20))),
                                onPressed: () {
                                  // context.read<Cart>().addToCart();
                                },
                                child: const Text(
                                  'ADD',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: kPrimaryGreen.withAlpha(20),
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: const Color(0xFF666c63))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // context.read<Cart>().removeFromCart();
                                        },
                                        borderRadius: BorderRadius.circular(40),
                                        radius: 40,
                                        splashColor:
                                            kPrimaryGreen.withAlpha(20),
                                        child: const Icon(
                                          Icons.remove_rounded,
                                          size: 24,
                                        ),
                                      ),
                                      // Text('${context.watch<Cart>().cart}'),
                                      InkWell(
                                        onTap: () {
                                          // context.read<Cart>().addToCart();
                                        },
                                        borderRadius: BorderRadius.circular(40),
                                        radius: 40,
                                        splashColor:
                                            kPrimaryGreen.withAlpha(20),
                                        child: const Icon(
                                          Icons.add_rounded,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
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

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '$title',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final MenuItemModel menu;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: kBoxShadowList),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                  ),
                  child: Image.asset(
                      'assets/images/fries.jpg', //TODO: Use imageUrl here
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.menu.itemName}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    '${widget.menu.servingQuantity}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                                // Text(
                                //   'Noon',
                                //   style: TextStyle(),
                                // ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.black54,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '${widget.menu.preparationTime} mins',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Consumer<Cart>(
                          builder: (context, cartProvider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    '₹ ${widget.menu.price}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            !cartProvider.cart.containsKey(widget.menu.itemId.toString())
                                ? OutlinedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 32)),
                                        surfaceTintColor:
                                            MaterialStateProperty.all(
                                                kPrimaryGreen),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kPrimaryGreen.withAlpha(20))),
                                    onPressed: () {
                                      cartProvider.addItemToCart(widget.menu.itemId.toString(), widget.menu.price!, widget.menu);
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14.0),
                                      child: Text(
                                        'ADD',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 11),
                                    decoration: BoxDecoration(
                                        color: kPrimaryGreen.withAlpha(20),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: const Color(0xFF666c63))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // context.read<Cart>().removeFromCart('${widget.menu.itemId}', widget.menu.price!);
                                            cartProvider.removeItemFromCart(widget.menu.itemId.toString(), widget.menu.price!);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          radius: 40,
                                          splashColor:
                                              kPrimaryGreen.withAlpha(20),
                                          child: const Icon(
                                            Icons.remove_rounded,
                                            size: 24,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                              '${cartProvider.cart[widget.menu.itemId.toString()]![1]}'),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cartProvider
                                                .addItemToCart(widget.menu.itemId.toString(), widget.menu.price!, widget.menu);
                                          },
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          radius: 40,
                                          splashColor:
                                              kPrimaryGreen.withAlpha(20),
                                          child: const Icon(
                                            Icons.add_rounded,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CanteenChipComponent extends StatelessWidget {
  const CanteenChipComponent({
    Key? key,
    required this.text,
    required this.keyValue,
    required this.canteenId,
    required this.canteenName,
  }) : super(key: key);

  final String? text;
  final String? canteenId;
  final String? canteenName;
  final int? keyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ChoiceChip(
        label: Text('$text'),
        labelStyle: const TextStyle(fontSize: 12),
        side: context.watch<CanteenProvider>().value == keyValue
            ? BorderSide(color: kPrimaryGreen)
            : BorderSide(color: Colors.grey.shade300),
        selectedColor: kPrimaryGreenAccent,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: kPrimaryGreen)),
        labelPadding: EdgeInsets.zero,
        selected: context.watch<CanteenProvider>().value == keyValue,
        onSelected: (bool selected) {
          if (selected) {
            if (context.read<Cart>().cart.isNotEmpty) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: const Text(
                            'Switching to a different canteen will remove existing items in the cart. Discard items?'),
                        contentPadding:
                            const EdgeInsets.only(top: 20, left: 24, right: 24),
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
                                selected
                                    ? context
                                        .read<CanteenProvider>()
                                        .updateValue(
                                            keyValue!, canteenId!, canteenName!)
                                    : null;
                              },
                              child: const Text('Discard'))
                        ],
                      ));
            } else if (context.read<Cart>().cart.isEmpty) {
              selected
                  ? context
                      .read<CanteenProvider>()
                      .updateValue(keyValue!, canteenId!, canteenName!)
                  : null;
            }
          }
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
    required this.canteenId,
  }) : super(key: key);

  final CategoryModel category;
  final String canteenId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CanteenProvider>(context, listen: false)
            .getMenuItemsInCategory(canteenId, category.categoryId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryItemsScreen(
              selectedCategory: category,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
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
                  '${category.categoryName}',
                  style: const TextStyle(
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
