import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Practitioner/pr_homepage.dart';
import '../User/Bottom_Navigation.dart';
import '7.Waiting_Page.dart';

class witing_page2 extends StatefulWidget {
  const witing_page2({super.key});

  @override
  State<witing_page2> createState() => _witing_page2State();
}

class _witing_page2State extends State<witing_page2> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeebe6),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/power1.png',
              height: 200,
            ),
            SpinKitPulse(
              color: Colors.blueGrey,
              size: 200,
            )
          ],
        ),
      ),
    );
  }
}
