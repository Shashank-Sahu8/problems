import 'package:flutter/material.dart';
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
