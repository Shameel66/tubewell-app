import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:tubewell_app/view/tubeWell/tubewell1.dart';
import 'package:tubewell_app/view/tubeWell/tubewell12.dart';
import 'package:tubewell_app/view/tubeWell/tubewell15.dart';
import 'package:tubewell_app/view/tubeWell/tubewell2.dart';
import 'package:tubewell_app/view/tubeWell/tubewell3.dart';
import 'package:tubewell_app/view/tubeWell/tubewell4.dart';
import 'package:tubewell_app/view/tubeWell/tubewell5.dart';
import 'package:tubewell_app/view/tubeWell/tubewell6.dart';
import 'package:tubewell_app/view/tubeWell/tubewell7.dart';
import 'package:tubewell_app/view/tubeWell/tubewell8.dart';
import 'package:tubewell_app/view/tubeWell/tubewell9.dart';

import 'tubeWell/tubewell10.dart';
import 'tubeWell/tubewell11.dart';
import 'tubeWell/tubewell13.dart';
import 'tubeWell/tubewell14.dart';
import 'tubeWell/tubewell16.dart';
import 'tubeWell/tubewell17.dart';
import 'tubeWell/tubewell18.dart';
import 'tubeWell/tubewell19.dart';
import 'tubeWell/tubewell20.dart';
import 'tubeWell/tubewell21.dart';
import 'tubeWell/tubewell22.dart';
import 'tubeWell/tubewell23.dart';
import 'tubeWell/tubewell24.dart';
import 'tubeWell/tubewell25.dart';

class TubeWell extends StatefulWidget {
  @override
  _TubeWellState createState() => _TubeWellState();
}

class _TubeWellState extends State<TubeWell> {
  late DatabaseReference _dbref;
  late DatabaseReference _schedule;
  bool switchValue = false;
  int _onFlag = 0;
  var _lvFlag = 0;
  var _peError = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _schedule = FirebaseDatabase(databaseURL: '').reference().child('Op');
    _schedule.child('output').onValue.listen((event) {
      final time = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final startTime1 = "${time['Start_HourR1']}";
      final startTime2 = "${time['Start_HourR2']}";

      setState(() {
        _startTime1 = startTime1;
        _startTime2 = startTime2;
      });
    });
    _dbref = FirebaseDatabase.instance.reference().child('Op');
    _dbref.child('input').onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final onFlag = data['ON_Flag'];
      final lvFlag = data['LV_Flag'];
      final peError = data['FE_Flag'];
      setState(() {
        _onFlag = onFlag;
        _lvFlag = lvFlag;
        _peError = peError;
      });
    });
  }
final databaseref = FirebaseDatabase(databaseURL: "").reference().child("Op");
  String _startTime1 = "";
  String _startTime2 = "";
  TextEditingController r1Controller = TextEditingController();
  TextEditingController r2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              title: Text("Tubewell NO.1"),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Status:",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _onFlag == 1 ? Colors.green : Colors.grey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Low Voltage:",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _lvFlag == 1 ? Colors.green : Colors.grey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Phase Error:",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _peError == 1 ? Colors.red : Colors.grey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.0)),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Auto',
                        ),
                        Tab(
                          text: 'Custom',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 150,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Rest Hour 1"),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    color: Colors.grey,
                                    child: Center(child: Text("${_startTime1}")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Rest Hour 2"),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    color: Colors.grey,
                                    child: Center(child: Text("${_startTime2}")),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Rest Hour 1"),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    color: Colors.grey,
                                    child: TextFormField(
                                      controller: r1Controller,
                                      textAlign: TextAlign.center,
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )),

                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Rest Hour 2"),
                                  Container(
                                    height: 30,
                                    width: 100,
                                    color: Colors.grey,
                                    child: TextFormField(
                                      controller: r2Controller,
                                      textAlign: TextAlign.center,
                                      cursorColor: Colors.white,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  if(r1Controller.text.isNotEmpty && r2Controller.text.isNotEmpty){
                                    InsertR1(r1Controller.text,r2Controller.text);
                                  }
                                },
                                color: Color(0xff2E5984),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                child: Text("Apply"),
                              )
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 180,
                      child: LiquidLinearProgressIndicator(
                        value: 0.75,
                        valueColor: AlwaysStoppedAnimation(Colors.blue),
                        backgroundColor: Colors.white,
                        // Defaults to the current Theme's backgroundColor.
                        borderColor: Colors.black,
                        borderWidth: 5.0,
                        borderRadius: 12.0,
                        direction: Axis.vertical,
                        center: Text(
                          "80 %",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ), //text inside bar
                      )),
                ],
              ),
            ),
            drawer: SafeArea(
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: const Text('TubeWell 1'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell1()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 2'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell2()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 3'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell3()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 4'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell4()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 5'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell5()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 6'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell6()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 7'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell7()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 8'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell8()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 9'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell9()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 10'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell10()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 11'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell11()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 12'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell12()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 13'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell13()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 14'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell14()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 15'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell15()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 16'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell16()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 17'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell17()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 18'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell18()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 19'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell19()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 20'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell20()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 21'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell21()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 22'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell22()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 23'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell23()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 24'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell24()));
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: const Text('TubeWell 25'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TubeWell25()));
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            )));
  }
  void InsertR1(String rest1 ,String rest2){
    databaseref.child('output').update({
      'Start_HourR1': rest1,
      'Start_HourR2': rest2,
    });
    r1Controller.clear();
    r2Controller.clear();
  }
}
