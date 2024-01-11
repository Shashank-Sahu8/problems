import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../Theme/Theme.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "log out", backgroundColor: Colors.grey);
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterSwitch(
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
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  onToggle: (val) {
                    setState(() {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                      status = val;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
