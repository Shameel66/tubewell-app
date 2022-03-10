import 'package:flutter/material.dart';
import 'package:tubewell_app/view/allTab.dart';
import 'package:tubewell_app/view/statsTab.dart';
import 'package:tubewell_app/view/tubeWellTab.dart';




class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool isSwitched = false;
  int _currentIndex = 0;
  final List _children = [
    Statistics(),
    All(),
    TubeWell(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: Color.fromARGB(255, 2, 31, 102),
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            label: "Statistics"
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Tubewell",
          ),
        ],
      ),
    );
  }
}
