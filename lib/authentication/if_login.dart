import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_power/authentication/verify_mail.dart';

import '../Bottom_Navigation.dart';
import 'login1.dart';
import 'loginemail.dart';

class islogein extends StatelessWidget {
  const islogein({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return verify_mail();
          } else {
            return login();
          }
        },
      ),
    );
  }
}
