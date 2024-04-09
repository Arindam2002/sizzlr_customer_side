import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../Home/HomeScreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key, required this.mobileNumber}) : super(key: key);

  final String mobileNumber;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _authenticationFormKey = GlobalKey<FormState>();
  late String instituteName = '';
  late String canteenName = '';
  late String managerName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreenAccent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _authenticationFormKey,
            child: LayoutBuilder(builder: (context, constraints) => ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: constraints.maxHeight
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Hero(
                          tag: 'Logo',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 40),
                            child: Image.asset(
                              'assets/images/sizzlr_logo.png',
                              scale: 6,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 40),
                          child: Text(
                            'A seamless canteen experience',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: kBoxShadowList,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: TextFormField(
                                autofocus: true,
                                onChanged: (val) {
                                  instituteName = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 12),
                                decoration: kFormFieldDecoration.copyWith(labelText: 'Institute Name',)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: TextFormField(
                                autofocus: true,
                                onChanged: (val) {
                                  canteenName = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 12),
                                decoration: kFormFieldDecoration.copyWith(labelText: 'Canteen\'s Name',)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: TextFormField(
                                autofocus: true,
                                onChanged: (val) {
                                  managerName = val;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 12),
                                decoration: kFormFieldDecoration.copyWith(labelText: 'Manager\'s Name',)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                            child: TextFormField(
                              enabled: false,
                                initialValue: widget.mobileNumber,
                                style: const TextStyle(fontSize: 12),
                                decoration: kFormFieldDecoration.copyWith(labelText: 'Manager\'s Name',)
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12.5),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_authenticationFormKey.currentState!.validate()) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Register'),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
              ),
                ),
              ]
            ),),
          ),
        ),
      ),
    );
  }
}
