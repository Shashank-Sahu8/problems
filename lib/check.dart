import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_power/Bottom_Navigation.dart';
import 'package:project_power/authentication/loginemail.dart';
import 'package:project_power/practitioner_section.dart';

class check_if_user_or_practitioner extends StatefulWidget {
  const check_if_user_or_practitioner({super.key});

  @override
  State<check_if_user_or_practitioner> createState() =>
      _check_if_user_or_practitionerState();
}

class _check_if_user_or_practitionerState
    extends State<check_if_user_or_practitioner> {
  bool checkk = false;
  // _fetch() async {
  //   final firebaseuser = await FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    //  CollectionReference user=FirebaseFirestore.instance.collection('User')
    //      .doc('details')
    //      .collection('data');
    // Future<bool> ccc() async {
    //   await user.doc(uid).get().then((doc){
    //     if(doc.exists){
    //       doc.data()?.forEach((key, value) {
    //         if(key == 'field'){
    //           var valueOfField = value;
    //         }
    //       });
    //     }
    //   });
    //   return true;
    // }
    // var doc= user.doc(uid).get();
    // Map<String, dynamic> map = doc.data();
    // if(map.containsKey('check')){
    //   var vall=map['check'];
    // }
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc('details')
          .collection('data')
          .snapshots(),
      builder: (context, snapshot) {
        final docs = snapshot.data!.docs;
        if (docs[0]['practitioner'] == true) {
          if (docs[0]['check'] == true) return pr_home();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ),
          ),
        );
      },
    ));
  }
}
