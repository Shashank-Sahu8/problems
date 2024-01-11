import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_power/authentication/verify_mail.dart';
import 'package:project_power/user_data.dart';
import '../Bottom_Navigation.dart';
import 'login1.dart';
import 'loginemail.dart';

final userRef = FirebaseFirestore.instance
    .collection('User')
    .doc('details')
    .collection('data')
    .doc(FirebaseAuth.instance.currentUser!.uid);

class islogein extends StatefulWidget {
  islogein({super.key});

  @override
  State<islogein> createState() => _islogeinState();
}

bool cc = false;

class _islogeinState extends State<islogein> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // checkuserforpermission();
  // }

  checkuserforpermission() async {
    late bool c;
    userRef.get().then((DocumentSnapshot doc) {
      c = doc['practitioner'];
    });
    return c;
  }

  check() async {
    bool t = await checkuserforpermission();
    return t;
  }

  @override
  Widget build(BuildContext context) {
    //   return FutureBuilder<FirebaseUser>(
    //       future: FirebaseAuth.instance.currentUser!!!,
    //       builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
    //         if (snapshot.hasData){
    //           FirebaseUser user = snapshot.data; // this is your user instance
    //           /// is because there is user already logged
    //           return MainScreen();
    //         }
    //         /// other way there is no user logged.
    //         return LoginScreen();
    //       }
    //   );
    // }
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return verify_mail(
              checka: false,
            );
          } else {
            return user_data();
          }
        },
      ),
    );
  }
}
