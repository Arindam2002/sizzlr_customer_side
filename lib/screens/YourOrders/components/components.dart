import 'dart:async';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class MyOrderCard extends StatelessWidget {
  const MyOrderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: kBoxShadowList,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Container(
              color: Color(0x99f0f0f0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#121',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'H3 Canteen',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Tooltip(
                    key: tooltipkey,
                    message: 'Preparing',
                    child: GestureDetector(
                      onTap: () {
                        tooltipkey.currentState?.ensureTooltipVisible();
                        Timer(Duration(seconds: 2), () {
                          tooltipkey.currentState?.deactivate();
                        });

                      },
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Color(0xFFFFDB58),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VEG / NON-VEG
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Icon(
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
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'itemName ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              TextSpan(
                                text: '(x2)',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                            ])),
                            Text(
                              'Serves: 2 pc.s',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VEG / NON-VEG
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Icon(
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
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'itemName ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              TextSpan(
                                text: '(x2)',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                              ),
                            ])),
                            Text(
                              'Serves: 2 pc.s',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DottedLine(
                direction: Axis.horizontal,
                dashColor: Colors.black54.withAlpha(60),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '01 Jan 2023 at 8:02AM',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '₹200',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              DottedLine(
                direction: Axis.horizontal,
                dashColor: Colors.black54.withAlpha(60),
              )
            ],
          ),
        ],
      ),
    );
  }
}
