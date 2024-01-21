import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:project_power/Model/UserModel.dart';
import 'package:project_power/Starting_Flow/3.ii.%20Practitioner_Details.dart';
import '../Auth_Files/google sign_in.dart';
import '3.i.Personal_Details.dart';
import '4.Login.dart';

class signup extends StatefulWidget {
  bool check;
  signup({super.key, required this.check});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  bool loading = false;
  bool show = false;
  bool ob = true;
  bool isChecked = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/power1.png',
                  height: 40,
                ),
                // CircleAvatar(
                //   backgroundColor: Color(0xffAD00FF),
                //   radius: 35,
                //   child: CircleAvatar(
                //       radius: 33,
                //       backgroundColor: Colors.white,
                //       child: CircleAvatar(
                //         radius: 30.5,
                //         backgroundColor: Colors.grey,
                //       )),
                // ),
                SizedBox(
                  height: 22,
                ),
                Form(
                    key: formfield,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: namecontroller,
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            focusColor: Color(0xff8F57FF),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            focusColor: Color(0xff8F57FF),
                            fillColor: Color(0xff8F57FF),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: ob == true ? true : false,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ob = !ob;
                                });
                              },
                              icon: ob == true
                                  ? Icon(
                                      FontAwesome.eye_slash,
                                      size: 23,
                                    )
                                  : Icon(
                                      FontAwesome.eye,
                                      size: 23,
                                      color: Color(0xff7F3DFF),
                                    ),
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 17),
                            focusColor: Color(0xff8F57FF),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            MSHCheckbox(
                              size: 23,
                              value: isChecked,
                              colorConfig:
                                  MSHColorConfig.fromCheckedUncheckedDisabled(
                                checkedColor: Color(0xff7F3DFF),
                              ),
                              style: MSHCheckboxStyle.stroke,
                              onChanged: (selected) {
                                setState(() {
                                  isChecked = selected;
                                });
                              },
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => login()));
                                  },
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: "By signing up,you agree to the ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text:
                                            "Terms of \n Services and Privacy Policy",
                                        style: TextStyle(
                                            color: Color(0xff7F3DFF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ]),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.check == false) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => presonal_details(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                              name: namecontroller.text,
                                              google: false,
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            practitioner_details(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                              name: namecontroller.text,
                                              google: false,
                                            )));
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff7F3DFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Or with",
                          style: GoogleFonts.inter(
                              color: Color(0xff91919F),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                              var res = await AuthServices().signInWithGoogle();
                              if (res.additionalUserInfo!.isNewUser) {
                                if (widget.check == false) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              presonal_details(
                                                email: emailcontroller.text,
                                                password:
                                                    passwordcontroller.text,
                                                name: namecontroller.text,
                                                google: true,
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              practitioner_details(
                                                email: emailcontroller.text,
                                                password:
                                                    passwordcontroller.text,
                                                name: namecontroller.text,
                                                google: true,
                                              )));
                                }
                              } else {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg: 'Login success',
                                  backgroundColor: Colors.grey,
                                  textColor: Color(0xff7F3DFF),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/google.png'),
                                  height: 33,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Sign Up with Google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                )
                              ],
                            ),
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.inter(
                                  color: Color(0xff91919F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => login()));
                                  },
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.inter(
                                        color: Color(0xff7F3DFF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class utils {
  toastmess(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.orange,
        fontSize: 16.0);
  }
}
