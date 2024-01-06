import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Pages%20View/Claender.dart';
import 'package:project_power/Pages%20View/Community.dart';
import 'package:project_power/Pages%20View/Explore.dart';
import 'package:project_power/Pages%20View/Profile.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

const pageindex = [home(),explore(),community(),calender(),profile()];

class _homeState extends State<home> {
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff00A36e),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Upload"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "User"),
        ],
      ),
      body: Center(
        child: pageindex[page],
      ),
    );
  }
}
