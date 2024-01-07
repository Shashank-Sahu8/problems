import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class pr_home extends StatefulWidget {
  const pr_home({super.key});

  @override
  State<pr_home> createState() => _pr_homeState();
}

class _pr_homeState extends State<pr_home> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Practitioner Section"),
      ),
    );
  }
}
