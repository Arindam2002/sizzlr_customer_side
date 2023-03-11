import 'package:flutter/material.dart';

class WaitingForOrderConfirmationScreen extends StatefulWidget {
  const WaitingForOrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<WaitingForOrderConfirmationScreen> createState() => _WaitingForOrderConfirmationScreenState();
}

class _WaitingForOrderConfirmationScreenState extends State<WaitingForOrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Waiting for the confirmation from the canteen'))
    );
  }
}
