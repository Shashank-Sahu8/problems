import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Bottom_Navigation.dart';
import 'login1.dart';

class islogein extends StatelessWidget {
  const islogein({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshort) {
          if (snapshort.hasData) {
            return home();
          } else {
            return login1();
          }
        },
      ),
    );
  }
}
