import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_picker_plus/country_state_picker_plus.dart';
import 'package:datetime_picker_field_platform/datetime_picker_field_platform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '8.If_Login_Or_not.dart';

class practitioner_details extends StatefulWidget {
  String email, name, password;
  bool google;
  practitioner_details(
      {super.key,
      required this.email,
      required this.name,
      required this.password,
      required this.google});

  @override
  State<practitioner_details> createState() => _practitioner_detailsState();
}

class _practitioner_detailsState extends State<practitioner_details> {
  final qualificationsc = TextEditingController();
  final experience = TextEditingController();
  final working = TextEditingController();
  final formfield = GlobalKey<FormState>();
  DateTime? selectedDate;
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
      'practitioner': true,
      'Qualifications': qualificationsc.text,
      'Experience': experience.text,
      'Currently_working': working.text
    });
  }

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              "Practitioner Details",
              style: GoogleFonts.aBeeZee(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
            ),
            height: 70,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Form(
                    key: formfield,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Qualifications :",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: qualificationsc,
                              decoration: const InputDecoration(
                                  hintText: "Qualifications",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  focusColor: Color(0xff8F57FF),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Experience(in years) :",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: experience,
                              decoration: const InputDecoration(
                                  hintText: "Years of Experience",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  focusColor: Color(0xff8F57FF),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Currently working in :",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: working,
                              decoration: const InputDecoration(
                                  hintText: "Working",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  focusColor: Color(0xff8F57FF),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Location :",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 8.0, left: 8.0, right: 8.0),
                            child: CountryStatePickerPlus(
                              onCityChanged: (value) {
                                result += ' $value';
                                setState(() {});
                              },
                              onCountryChanged: (value) {
                                result = value;
                                setState(() {});
                              },
                              onStateChanged: (value) {
                                result += ' $value';
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 180,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formfield.currentState!.validate()) {
                                    if (widget.google == true) {
                                      addfire();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  islogein()));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          });
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: widget.email,
                                              password: widget.password)
                                          .then((value) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Account created & Login success",
                                            backgroundColor: Colors.grey,
                                            textColor: Color(0xff7F3DFF));
                                        addfire();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }).onError((error, stackTrace) {
                                        Fluttertoast.showToast(
                                            msg: error.toString(),
                                            backgroundColor: Colors.grey,
                                            textColor: Color(0xff7F3DFF));
                                      });
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff7F3DFF),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("Continue",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
