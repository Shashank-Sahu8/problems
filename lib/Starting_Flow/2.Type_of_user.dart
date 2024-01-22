import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '3.SignUp.dart';

class user_data extends StatefulWidget {
  const user_data({super.key});

  @override
  State<user_data> createState() => _user_dataState();
}

class CheckProvider with ChangeNotifier {
  var obj = _user_dataState().practitioner;
}

class _user_dataState extends State<user_data> {
  bool practitioner = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup(check: false)));
                        },
                        child: Text(
                          "User",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signup(check: true)));
                        },
                        child: Text(
                          "Practitioner",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
