import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_power/Bottom_Navigation.dart';
import 'package:project_power/authentication/check2.0.dart';
import 'package:project_power/authentication/loginemail.dart';
import 'package:project_power/pr_homepage.dart';
import 'package:project_power/user_data.dart';

final userRef = FirebaseFirestore.instance
    .collection('User')
    .doc('details')
    .collection('data')
    .doc(FirebaseAuth.instance.currentUser!.uid);

class verify_mail extends StatefulWidget {
  bool checka;
  verify_mail({super.key, required this.checka});

  @override
  State<verify_mail> createState() => _verify_mailState();
}

class _verify_mailState extends State<verify_mail> {
  bool isvar = false;
  bool canresend = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  checkuserforpermission();
    isvar = FirebaseAuth.instance.currentUser!.emailVerified;
    checku();
    if (!isvar) {
      sendvar();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkemailverified());
    }
  }

  // bool checkf = false;
  // checkuserforpractitioner() async {
  //   userRef.get().then((DocumentSnapshot doc) {
  //     if (doc['check'] == true) return true;
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future checkemailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isvar = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isvar) timer?.cancel();
  }

  bool permission = false;
  Future checku() async {
    userRef.get().then((DocumentSnapshot doc) {
      print(doc.data());
      if (widget.checka == false && doc['practitioner'] == true) {
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => user_data()));
        Fluttertoast.showToast(
            msg:
                "Sorry you can not enter as user fb  ${doc['practitioner']}  ${widget.checka} wid");
      }
    });
  }

  Future sendvar() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canresend = true;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canresend = true;
      });
    } catch (e) {
      utils().toastmess(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isvar == true
      ? widget.checka == false
          ? bottomnav()
          : checkcheck()
      : Scaffold(
          appBar: AppBar(
            title: Text('verify Email'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "We have send you a verification email,kindly verify it to proceed."),
              SizedBox(
                height: 25,
              ),
              ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: () {
                  canresend ? sendvar() : null;
                },
                icon: Icon(Icons.email_outlined),
                label: Text(
                  'Resend Email',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: Text(
                    'Cnacel',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ))
            ],
          ),
        );
}
