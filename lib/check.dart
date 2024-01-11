import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_power/pr_homepage.dart';

final userRef = FirebaseFirestore.instance
    .collection('User')
    .doc('details')
    .collection('data')
    .doc(FirebaseAuth.instance.currentUser!.uid);

class check_if_user_or_practitioner extends StatefulWidget {
  const check_if_user_or_practitioner({super.key});
  @override
  State<check_if_user_or_practitioner> createState() =>
      _check_if_user_or_practitionerState();
}

class _check_if_user_or_practitionerState
    extends State<check_if_user_or_practitioner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkuserforpractitioner();
    checkuserforpermission();
  }

  checkuserforpractitioner() async {
    userRef.get().then((DocumentSnapshot doc) {
      if (doc['practitioner'] == false) {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "You are not a practitioner");
      }
    });
  }

  bool permission = false;
  checkuserforpermission() async {
    userRef.get().then((DocumentSnapshot doc) {
      setState(() {
        permission = doc['check'];
      });
    });
  }

  @override
  Widget build(BuildContext context) => permission == false
      ? Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.grey,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent),
                  onPressed: () {
                    checkuserforpractitioner();
                  },
                  child: Text("Check if Request granted")),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  },
                  child: Text("leave"))
            ],
          ),
        )
      : pr_homepage();
}
