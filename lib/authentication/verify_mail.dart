import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Bottom_Navigation.dart';
import 'package:project_power/authentication/loginemail.dart';

import '../user_data.dart';

class verify_mail extends StatefulWidget {
  const verify_mail({super.key});

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
    isvar = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isvar) {
      sendvar();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkemailverified());
    }
  }

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
      ? user_data()
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
                  style: TextStyle(fontSize: 24),
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
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          ),
        );
}
