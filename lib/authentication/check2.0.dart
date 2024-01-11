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

class checkcheck extends StatefulWidget {
  const checkcheck({super.key});

  @override
  State<checkcheck> createState() => _checkcheckState();
}

class _checkcheckState extends State<checkcheck> {
  //bool checkf = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkuserforpractitioner();
  }

  Future checkuserforpractitioner() async {
    userRef.get().then((DocumentSnapshot doc) {
      if (doc['check'] != false)
      // {
      //   FirebaseAuth.instance.signOut();
      //   Navigator.pop(context);
      //   Fluttertoast.showToast(
      //       msg:
      //           "You may not have access as practitioner,contact admin for request and login again",
      //       backgroundColor: Colors.grey);
      // }
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => pr_homepage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text("Leave")),
            ElevatedButton(
                onPressed: () {
                  checkuserforpractitioner();
                },
                child: Text("Check for permission")),
            CircularProgressIndicator(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
