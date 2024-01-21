import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class practitioner_details extends StatefulWidget {
  String email, name, password;
  practitioner_details(
      {super.key,
      required this.email,
      required this.name,
      required this.password});

  @override
  State<practitioner_details> createState() => _practitioner_detailsState();
}

class _practitioner_detailsState extends State<practitioner_details> {
  addfire() async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc('details')
        .collection('data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'id': FirebaseAuth.instance.currentUser!.uid,
      'name': widget.name,
      'email': widget.email,
      'check': false,
      'practitioner': true
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
