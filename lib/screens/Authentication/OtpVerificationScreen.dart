import 'package:flutter/material.dart';
import 'package:sizzlr_customer_side/constants/constants.dart';
import 'package:sizzlr_customer_side/screens/Authentication/RegistrationScreen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({ Key? key, required this.mobileNumber}) : super(key: key);

  final String mobileNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryGreenAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: LayoutBuilder(builder: (context, constraints) => ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 10.0, left: 10, top: 40, bottom: 30),
                      //   child: Image.asset(
                      //     'assets/images/sizzlr_logo.png',
                      //     scale: 6,
                      //   ),
                      // ),
                    Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "A verification code has been sent to +91 ${widget.mobileNumber}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: kBoxShadowList
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _textFieldOTP(first: true, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: false),
                              _textFieldOTP(first: false, last: true),
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(mobileNumber: widget.mobileNumber,),
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(onPressed: (){}, child: const Text('Resend Code'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: true,
            readOnly: false,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, textBaseline: TextBaseline.alphabetic),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              counter: Offstage(),
            ),
          ),
        ),
      ),
    );
  }
}
