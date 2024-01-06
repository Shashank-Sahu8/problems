import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'google sign_in.dart';
import 'lon2.dart';

class login1 extends StatefulWidget {
  const login1({super.key});

  @override
  State<login1> createState() => _login1State();
}

class _login1State extends State<login1> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  @override
  void initState() {
    getConnectivity();
    countrycode.text = "+91";
    super.initState();
  }

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  TextEditingController countrycode = TextEditingController();
  TextEditingController number = TextEditingController();
  bool loading = false;
  String temp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white24,
        leading: Row(
          children: [
            SizedBox(
              width: 6,
            ),
            Image.asset(
              'assets/WW iconimg.jpg',
              height: 50,
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 27, right: 27),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 200,
                    width: 180,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'verify1__1_-removebg-preview.png')))),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Verification",
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.w600),
                ),
                Text(
                  "We need to register your phone number before getting started!",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        SizedBox(
                          width: 35,
                          child: TextField(
                            controller: countrycode,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Code"),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 35,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: TextField(
                          controller: number,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone number"),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (number.text.toString().length > 9) {
                        setState(() {
                          loading = !loading;
                        });
                        Fluttertoast.showToast(
                            backgroundColor: Colors.grey,
                            msg: "We are sending you an OTP");
                        FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '${countrycode.text + number.text}',
                            verificationCompleted:
                                (PhoneAuthCredential phoneAuthCredential) {
                              setState(() {
                                loading = !loading;
                              });
                            },
                            verificationFailed: (FirebaseAuthException error) {
                              Fluttertoast.showToast(
                                msg: error.toString(),
                                backgroundColor: Colors.grey,
                              );
                              setState(() {
                                loading = !loading;
                              });
                            }, //7388015234//273519
                            codeSent:
                                (String verificationId, int? ResendingToken) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => verifyotp(
                                            number: number.text.toString(),
                                            otp: verificationId,
                                          )));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {});
                      } else {
                        Fluttertoast.showToast(msg: "invalid number");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xff00A36e),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: loading == true
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Send OTP",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 0.6,
                      )),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 0.6,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    child: SignInButton(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      Buttons.google,
                      onPressed: () {
                        AuthServices().signInWithGoogle();
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
