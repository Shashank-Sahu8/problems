import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

import '../Bottom_Navigation.dart';

class verifyotp extends StatefulWidget {
  const verifyotp({super.key, required this.number, required this.otp});
  final number;
  final otp;
  @override
  State<verifyotp> createState() => _verifyotpState();
}

class _verifyotpState extends State<verifyotp> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: const Offset(0.0, 0.0),
          blurRadius: 0.01,
          spreadRadius: 0.07,
        )
      ],
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController code = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.white24,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(27),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  width: 180,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/verify2__1_-removebg-preview.png')))),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter OTP",
                style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Please enter the OTP which we have send on +91-${widget.number.toString()}.",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Pinput(
                controller: code,
                length: 6,
                androidSmsAutofillMethod:
                    AndroidSmsAutofillMethod.smsUserConsentApi,
                defaultPinTheme: defaultPinTheme,
                showCursor: true,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: widget.otp,
                              smsCode: code.text.toString());
                      FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => home()));
                      }).onError((error, stackTrace) {
                        Fluttertoast.showToast(
                            msg: error.toString(),
                            backgroundColor: Colors.grey);
                      });
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "Incorrect OTP", backgroundColor: Colors.grey);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff00A36e),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Did not get OTP, resend?",
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
