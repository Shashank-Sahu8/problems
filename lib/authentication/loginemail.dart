import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:project_power/authentication/signupemail.dart';
import 'package:project_power/authentication/verify_mail.dart';
import 'forgetpasswordemail.dart';
import 'if_login.dart';
// final userRef = FirebaseFirestore.instance
//     .collection('User')
//     .doc('details')
//     .collection('data')
//     .doc(FirebaseAuth.instance.currentUser!.uid);

class login extends StatefulWidget {
  bool c;
  login({super.key, required this.c});

  @override
  State<login> createState() => _loginState();
}

bool obtext = true;
final _auth = FirebaseAuth.instance;
String? uid = _auth.currentUser?.uid;

class _loginState extends State<login> {
  var time = DateTime.now();
  bool loading = false;
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final password = TextEditingController();
  bool cc = false;

  // checkuserforpractitioner() async {
  //   userRef.get().then((DocumentSnapshot doc) {
  //     print(doc.data());
  //     return doc['practitioner'];
  //   });
  // }

  void loginn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    setState(() {
      loading = !loading;
    });
    await _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text, password: password.text.toString())
        .then((value) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => verify_mail(
                    checka: widget.c,
                  )));
      // checkuserforpractitioner();
      // if (checkuserforpractitioner() == false && widget.c == true) {
      //   FirebaseAuth.instance.signOut();
      //   Fluttertoast.showToast(
      //       msg: "you are not practitioner", backgroundColor: Colors.grey);
      //   Navigator.pop(context);
      // }
      utils().toastmess(value.user!.email.toString());
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      debugPrint(error.toString());
      utils().toastmess(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 170,
                  child: Image.asset(
                    'assets/verify2__1_-removebg-preview.png',
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: _formfield,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 7.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Theme.of(context).colorScheme.tertiary,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              hintText: "Email",
                              helperText: "e.g. example@gmail.com",
                              icon: Icon(
                                Icons.email,
                                color: Colors.blueGrey,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).colorScheme.tertiary,
                          obscureText: obtext,
                          controller: password,
                          decoration: InputDecoration(
                            hintText: "Password",
                            helperText: "Name@123...",
                            icon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obtext = !obtext;
                                });
                              },
                              child: Icon(
                                obtext != false
                                    ? Bootstrap.eye_fill
                                    : Bootstrap.eye_slash,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter password';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => forgetpass(
                                        mail: emailcontroller.text,
                                      )));
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 10, right: 20.0, bottom: 20.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      if (_formfield.currentState!.validate()) {
                        loginn();
                      }
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Login")
                        ],
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup(
                                      check: widget.c,
                                    )));
                      },
                      child: Text(
                        "Create account",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                      ))
                ],
              )
            ],
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
        textColor: Color(0xff733E9E),
        fontSize: 16.0);
  }
}
