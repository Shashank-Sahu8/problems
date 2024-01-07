import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Bottom_Navigation.dart';
import 'package:project_power/authentication/loginemail.dart';
import 'package:project_power/practitioner_section.dart';

import 'check.dart';

class user_data extends StatefulWidget {
  const user_data({super.key});

  @override
  State<user_data> createState() => _user_dataState();
}

class _user_dataState extends State<user_data> {
  bool practitioner = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 50,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('User')
                          .doc('details')
                          .collection('data')
                          .doc(uid)
                          .update({'practitioner': true});
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => pr_home()));
                    },
                    child: Text(
                      "Practitioner",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  check_if_user_or_practitioner()));
                    },
                    child: Text(
                      "User",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
