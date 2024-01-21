import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_power/User/Bottom_Navigation.dart';
import 'package:project_power/Starting_Flow/4.Login.dart';
import 'package:project_power/Practitioner/pr_homepage.dart';
import 'package:project_power/Starting_Flow/2.Type_of_user.dart';

import '7.Waiting_Page.dart';

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

  route() {
    var kk = FirebaseFirestore.instance
        .collection('User')
        .doc('details')
        .collection('data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('practitioner') == true) {
          if (documentSnapshot.get('check') == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => pr_homepage(),
              ),
            );
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => wait()));
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => bottomnav(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database' +
            "${FirebaseAuth.instance.currentUser!.uid}");
      }
    });
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
      ? route()
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
