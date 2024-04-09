import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizzlr_customer_side/constants/constants.dart';
import 'package:sizzlr_customer_side/providers/authProvider.dart';
import 'package:sizzlr_customer_side/screens/Authentication/OtpVerificationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authenticationFormKey = GlobalKey<FormState>();
  final bool userExists = false;

  late String mobileNumber;
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: kPrimaryGreenAccent,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: LayoutBuilder(
              builder: (context, constraints) => ListView(
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
                            child: Image.asset(
                              // 'assets/images/sizzlr_logo.png',
                              'assets/images/splash-green.png',
                              scale: 6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 40),
                            child: Text(
                              'A seamless canteen experience',
                              style: TextStyle(
                                color: kPrimaryGreen,
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
                          boxShadow: kBoxShadowList
                        ),
                        child: Column(
                          children: [
                            Form(
                              key: _authenticationFormKey,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: TextFormField(
                                    // autofocus: true,
                                    onChanged: (val) {
                                      mobileNumber = val;
                                    },
                                    keyboardType: TextInputType.phone,
                                    validator: (val) {
                                      if (val?.length != 10) {
                                        return 'Invalid Mobile number';
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(fontSize: 12),
                                    decoration: kFormFieldDecoration.copyWith(
                                      labelText: 'Mobile Number',
                                    )),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (_authenticationFormKey.currentState!
                                          .validate()) {
                                        //TODO: #1 OTP Authentication (If user exists, redirect to Home screen else, registration screen)
                                        print(mobileNumber);

                                        if (userExists) {
                                          setState(() {
                                            loading = false;
                                          });
                                          print('Navigating to Home Screen');
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OtpVerificationScreen(mobileNumber: mobileNumber,)),
                                          );
                                        }
                                      }
                                    },
                                    child: const Text('Get OTP'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      await authProvider.signInWithGoogle();
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: const Text('Sign In with Google'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),),
          ),
        ),
      ),
    );
  }
}
