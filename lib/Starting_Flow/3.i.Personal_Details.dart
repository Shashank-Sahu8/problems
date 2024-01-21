import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../Model/UserModel.dart';

class presonal_details extends StatefulWidget {
  String email, name, password;
  presonal_details(
      {super.key,
      required this.email,
      required this.name,
      required this.password});

  @override
  State<presonal_details> createState() => _presonal_detailsState();
}

class _presonal_detailsState extends State<presonal_details> {
  addfire() async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc('details')
        .collection('data')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'id': FirebaseAuth.instance.currentUser!.uid,
      'name': widget.name,
      'dob': "",
      'height': "",
      'weight': '',
      'condition': "",
      'email': widget.email,
      'check': false,
      'practitioner': false
    });
  }

  final heightc = TextEditingController();
  final weightc = TextEditingController();
  final conditionc = TextEditingController();
  final formfield = GlobalKey<FormState>();
  //DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Form(child: child)
            Form(
              key: formfield,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  // // Container(
                  // //   child: Padding(
                  // //     padding: const EdgeInsets.all(4.0),
                  // //     child: TextFormField(
                  // //       keyboardType: TextInputType.datetime,
                  // //       controller: heightc,
                  // //       decoration: const InputDecoration(
                  // //         hintText: "Birth Year",
                  // //         hintStyle:
                  // //             TextStyle(color: Colors.grey, fontSize: 17),
                  // //         focusColor: Color(0xff8F57FF),
                  // //         border: InputBorder.none,
                  // //       ),
                  // //       validator: (value) {
                  // //         if (value!.isEmpty) {
                  // //           return 'Enter Birth Year';
                  // //         }
                  // //         return null;
                  // //       },
                  // //     ),
                  // //   ),
                  // //   height: 50,
                  // //   width: 300,
                  // //   decoration: BoxDecoration(
                  // //       border: Border.all(color: Colors.grey),
                  // //       borderRadius: BorderRadius.circular(15)),
                  // // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   // child: Padding(
                  //   //     padding: const EdgeInsets.all(4.0),
                  //   //     child: DateTimeFormField(
                  //   //       decoration:
                  //   //           const InputDecoration(labelText: 'Enter Date'),
                  //   //       mode: DateTimeFieldPickerMode.date,
                  //   //       onChanged: (DateTime? value) {
                  //   //         print(value);
                  //   //       },
                  //   //     )),
                  //   height: 50,
                  //   width: 300,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Colors.grey),
                  //       borderRadius: BorderRadius.circular(15)),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: heightc,
                    decoration: const InputDecoration(
                      hintText: "Height",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                      focusColor: Color(0xff8F57FF),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Height';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: weightc,
              decoration: const InputDecoration(
                hintText: "Weight",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                focusColor: Color(0xff8F57FF),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter weight';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: conditionc,
              decoration: const InputDecoration(
                hintText: "Health conditions",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                focusColor: Color(0xff8F57FF),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
