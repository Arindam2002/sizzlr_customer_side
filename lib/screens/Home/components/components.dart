import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../providers/canteenFilterProvider.dart';
import '../../../providers/cartProvider.dart';

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
      actionsPadding: EdgeInsets.symmetric(horizontal: 0),
      titlePadding: EdgeInsets.only(left: 0, right: 0, bottom: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: const Text('Add item'),
      content: ListView(
        children: [
          SizedBox(
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
                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                          ? Icon(
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
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
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
      actionsPadding: EdgeInsets.symmetric(horizontal: 0),
      titlePadding: EdgeInsets.only(left: 0, right: 0, bottom: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: const Text('Edit item'),
      content: ListView(
        children: [
          SizedBox(
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
                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 12),
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
                          ? Icon(
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
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
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
                offset: Offset(2, 2),
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
                    Padding(
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 10),
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
                                    const EdgeInsets.symmetric(horizontal: 3),
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
                        child: context.watch<Cart>().cart == 0
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
                                  context.read<Cart>().addToCart();
                                },
                                child: Text(
                                  'ADD',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: kPrimaryGreen.withAlpha(20),
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Color(0xFF666c63))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.read<Cart>().removeFromCart();
                                        },
                                        borderRadius: BorderRadius.circular(40),
                                        radius: 40,
                                        splashColor:
                                            kPrimaryGreen.withAlpha(20),
                                        child: Icon(
                                          Icons.remove_rounded,
                                          size: 24,
                                        ),
                                      ),
                                      Text('${context.watch<Cart>().cart}'),
                                      InkWell(
                                        onTap: () {
                                          context.read<Cart>().addToCart();
                                        },
                                        borderRadius: BorderRadius.circular(40),
                                        radius: 40,
                                        splashColor:
                                            kPrimaryGreen.withAlpha(20),
                                        child: Icon(
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
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key? key,
    required this.dishName,
    required this.quantity,
    required this.estTime,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  final String? dishName;
  final String? quantity;
  final int? estTime;
  final int? price;
  final String? imageUrl;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool switchVal = false;

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
                                  '${widget.dishName}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(
                                    '${widget.quantity}',
                                    style: TextStyle(
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
                                Icon(
                                  Icons.timer_outlined,
                                  color: Colors.black54,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '${widget.estTime} mins',
                                  style: TextStyle(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10),
                                child: Text(
                                  '₹ ${widget.price}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          context.watch<Cart>().cart == 0
                              ? OutlinedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 32)),
                                      surfaceTintColor: MaterialStateProperty.all(
                                          kPrimaryGreen),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      )),
                                      backgroundColor: MaterialStateProperty.all(
                                          kPrimaryGreen.withAlpha(20))),
                                  onPressed: () {
                                    context.read<Cart>().addToCart();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                                    child: Text(
                                      'ADD',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 11),
                                decoration: BoxDecoration(
                                    color: kPrimaryGreen.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Color(0xFF666c63))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.read<Cart>().removeFromCart();
                                      },
                                      borderRadius: BorderRadius.circular(40),
                                      radius: 40,
                                      splashColor:
                                          kPrimaryGreen.withAlpha(20),
                                      child: Icon(
                                        Icons.remove_rounded,
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text('${context.watch<Cart>().cart}'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.read<Cart>().addToCart();
                                      },
                                      borderRadius: BorderRadius.circular(40),
                                      radius: 40,
                                      splashColor:
                                          kPrimaryGreen.withAlpha(20),
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        ],
                      ),
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
    Key? key, required this.text, required this.keyValue,
  }) : super(key: key);

  final String? text;
  final int? keyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ChoiceChip(
        label: Text('$text'),
        labelStyle: TextStyle(fontSize: 12),
        side: context.watch<Filter>().value == keyValue ? BorderSide(color: kPrimaryGreen) : BorderSide(color: Colors.grey.shade300),
        selectedColor: kPrimaryGreenAccent,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: kPrimaryGreen)),
        labelPadding: EdgeInsets.zero,
        selected: context.watch<Filter>().value == keyValue,
        onSelected: (bool selected) {
          selected ? context.read<Filter>().updateValue(keyValue!) : null;
        },
      ),
    );
  }
}