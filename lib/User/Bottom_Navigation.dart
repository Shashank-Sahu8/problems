import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import '../Starting_Flow/8.If_Login_Or_not.dart';
import '../Theme/Theme.dart';
import 'Pages View/Calender.dart';
import 'Pages View/Community.dart';
import 'Pages View/Explore.dart';
import 'Pages View/Home.dart';
import 'Pages View/Profile.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _homeState();
}

const pageindex = [home(), explore(), community(), calender(), profile()];

class _homeState extends State<bottomnav> {
  int page = 0;
  String svgCode = RandomAvatarString('womens');
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff36454F),
                  borderRadius: BorderRadius.circular(10)),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RandomAvatar(
                          DateTime.now().toIso8601String(),
                          height: 50,
                          width: 52,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "App Name",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21),
                            ),
                            Text("mail")
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            thickness: 0.3,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () async {
                final googleCurrentUser =
                    GoogleSignIn().currentUser ?? await GoogleSignIn().signIn();
                if (googleCurrentUser != null)
                  await GoogleSignIn().disconnect();
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => islogein()));
                Fluttertoast.showToast(
                    msg: "log out", backgroundColor: Colors.grey);
              },
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Log Out",
                        style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      CircleAvatar(
                        child: Icon(Icons.logout_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () async {},
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Theme",
                        style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      FlutterSwitch(
                        width: 70.0,
                        height: 30.0,
                        valueFontSize: 10.0,
                        toggleSize: 24.0,
                        activeText: 'Light',
                        inactiveText: 'Dark',
                        activeIcon: Icon(
                          Bootstrap.sun,
                          color: Colors.orangeAccent,
                          size: 400,
                        ),
                        inactiveIcon: Icon(
                          FontAwesomeIcons.moon,
                          color: Colors.grey.shade800,
                          size: 400,
                        ),
                        value: status,
                        borderRadius: 30.0,
                        padding: 8.0,
                        showOnOff: true,
                        activeColor: Theme.of(context).colorScheme.surface,
                        onToggle: (val) {
                          setState(() {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                            status = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () async {},
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.logout_outlined),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Log Out",
                        style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: GestureDetector(
              onTap: () async {},
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.logout_outlined),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Log Out",
                        style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_2), label: "Community"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calender"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
      ),
      body: Center(
        child: pageindex[page],
      ),
    );
  }
}
