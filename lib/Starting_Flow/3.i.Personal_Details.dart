import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:datetime_picker_field_platform/datetime_picker_field_platform.dart';

import '../Auth_Files/google sign_in.dart';
import '8.If_Login_Or_not.dart';

class presonal_details extends StatefulWidget {
  String email, name, password;
  bool google;
  presonal_details(
      {super.key,
      required this.email,
      required this.name,
      required this.password,
      required this.google});

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
      'year': selectedDate?.year,
      'month': selectedDate?.month,
      'date': selectedDate?.day,
      'height': heightc.text,
      'weight': weightc.text,
      'condition': conditionc.text,
      'email': widget.google == true
          ? FirebaseAuth.instance.currentUser!.email
          : widget.email,
      'check': false,
      'practitioner': false,
    });
  }

  final heightc = TextEditingController();
  final weightc = TextEditingController();
  final conditionc = TextEditingController();
  final formfield = GlobalKey<FormState>();
  DateTime? selectedDate;
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
              "Personal Details",
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
                          height: 50,
                        ),
                        Text(
                          "Date of Birth :",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
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
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 8.0, left: 8.0),
                            child: DateTimeFieldPlatform(
                              textCancel: "Cancel",
                              textConfirm: "Confirm",
                              mode: DateMode.date,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(Icons.calendar_month),
                                  focusColor: Colors.green),
                              maximumDate:
                                  DateTime.now().add(const Duration(days: 720)),
                              minimumDate: DateTime.utc(1950),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter date';
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
                          "Height(in cm) :",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
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
                              keyboardType: TextInputType.number,
                              controller: heightc,
                              decoration: const InputDecoration(
                                  hintText: "Height",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  focusColor: Color(0xff8F57FF),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Height';
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
                          "Weight(in Kg) :",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
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
                              keyboardType: TextInputType.number,
                              controller: weightc,
                              decoration: const InputDecoration(
                                  hintText: "Weight",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  focusColor: Color(0xff8F57FF),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter weight';
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
                          "Any Health Condition:",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
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
                              controller: conditionc,
                              decoration: const InputDecoration(
                                  hintText: "Health conditions",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 17),
                                  focusColor: Color(0xff8F57FF),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 180,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formfield.currentState!.validate()) {
                                    if (widget.google == true) {
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (context) {
                                      //       return const Center(
                                      //         child:
                                      //             CircularProgressIndicator(),
                                      //       );
                                      //     });
                                      // await AuthServices().signInWithGoogle();
                                      addfire();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  islogein()));
                                      // Navigator.pop(context);
                                      // Fluttertoast.showToast(
                                      //   msg: 'Login success',
                                      //   backgroundColor: Colors.grey,
                                      //   textColor: Color(0xff7F3DFF),
                                      // );
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
