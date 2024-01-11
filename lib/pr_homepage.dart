import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class pr_homepage extends StatefulWidget {
  const pr_homepage({super.key});

  @override
  State<pr_homepage> createState() => _pr_homepageState();
}

class _pr_homepageState extends State<pr_homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(
                    msg: "log out", backgroundColor: Colors.grey);
                Navigator.pop(context);
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: Container(
          child: Center(child: Text("Practitioner Home page activated"))),
    );
  }
}
