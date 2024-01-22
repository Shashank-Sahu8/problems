import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Starting_Flow/6.Verify_Mail.dart';
import 'package:project_power/Starting_Flow/2.Type_of_user.dart';

class islogein extends StatefulWidget {
  islogein({super.key});

  @override
  State<islogein> createState() => _islogeinState();
}

class _islogeinState extends State<islogein> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return verify_mail();
          } else {
            return user_data();
          }
        },
      ),
    );
  }
}

// Flushbar(
// message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
// icon: Icon(
// Icons.info_outline,
// size: 28.0,
// color: Colors.blue[300],
// ),
// duration: Duration(seconds: 3),
// leftBarIndicatorColor: Colors.blue[300],
// )..show(context);
