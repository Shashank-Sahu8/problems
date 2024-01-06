import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Pages%20View/Claender.dart';
import 'package:project_power/Pages%20View/Community.dart';
import 'package:project_power/Pages%20View/Explore.dart';
import 'package:project_power/Pages%20View/Profile.dart';

import 'Pages View/Home.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _homeState();
}

const pageindex = [home(), explore(), community(), calender(), profile()];

class _homeState extends State<bottomnav> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff80A36e),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Community"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Calender"),
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
