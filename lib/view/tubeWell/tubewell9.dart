import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class TubeWell9 extends StatefulWidget {
  @override
  _TubeWell9State createState() => _TubeWell9State();
}

class _TubeWell9State extends State<TubeWell9> {
  late DatabaseReference _dbref;
  late DatabaseReference _schedule;
  bool switchValue = false;
  int _onFlag = 0;
  int _offFlag = 0;
  var _lvFlag = 0;
  var _peError = 0;
  String _startCustomTime1 = "";
  String _startCustomTime2 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _schedule = FirebaseDatabase(databaseURL: 'https://tubewell9-107b4-default-rtdb.asia-southeast1.firebasedatabase.app/').reference().child('Op');
    _schedule.child('output').once().then((event) {
      final time = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final startTime1 = "${time['Start_HourR1']} : ${time['Start_MinuteR1']}";
      final startTime2 = "${time['Start_HourR2']} : ${time['Start_MinuteR2']}";
      setState(() {
        _startTime1 = startTime1;
        _startTime2 = startTime2;
      });
    });
    _schedule = FirebaseDatabase(databaseURL: 'https://tubewell9-107b4-default-rtdb.asia-southeast1.firebasedatabase.app/').reference().child('Op');
    _schedule.child('output').onValue.listen((event) {
      final time = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final startTime1 = "${time['Start_HourR1']} : ${time['Start_MinuteR1']}";
      final startTime2 = "${time['Start_HourR2']} : ${time['Start_MinuteR2']}";
      setState(() {
        _startCustomTime1 = startTime1;
        _startCustomTime2 = startTime2;
      });
    });
    _dbref = FirebaseDatabase(databaseURL: 'https://tubewell9-107b4-default-rtdb.asia-southeast1.firebasedatabase.app/').reference().child('Op');
    _dbref.child('input').onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final onFlag = data['ON_Flag'];
      final offFlag = data['OFF_Flag'];
      final lvFlag = data['LV_Flag'];
      final peError = data['FE_Flag'];
      setState(() {
        _lvFlag = lvFlag;
        _offFlag = offFlag;
        _peError = peError;
        if (_lvFlag == 1 || _peError == 1) {
          _onFlag = 0;
        } else {
          _onFlag = onFlag;
        }
        if (_lvFlag == 1 || _peError == 1) {
          _offFlag = 1;
        } else {
          _offFlag = offFlag;
        }
      });
    });
  }

  final databaseref = FirebaseDatabase(databaseURL: "https://tubewell9-107b4-default-rtdb.asia-southeast1.firebasedatabase.app/").reference().child("Op");
  String _startTime1 = "";
  String _startTime2 = "";
  TextEditingController r1Controller = TextEditingController();
  TextEditingController r2Controller = TextEditingController();
  TextEditingController r1MinController = TextEditingController();
  TextEditingController r2MinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            title: Text("Tubewell NO.9"),
            centerTitle: true,
            actions: [
              Switch(
                  value: switchValue,
                  activeColor: Colors.greenAccent,
                  inactiveThumbColor: Colors.red,
                  onChanged: (value){
                    if(value == true) {
                      if(mounted){
                        setState(() {
                          switchValue = true;
                          print(switchValue);
                        });}
                      _schedule.child('output').update({
                        'Start_IFlag': 1,
                        'Stop_IFlag' : 0
                      });
                    }
                    else{
                      setState(() {
                        switchValue = false;
                        print(switchValue);
                      });
                      _schedule.child('output').update({
                        'Start_IFlag': 0,
                        'Stop_IFlag' : 1
                      });
                    }
                  }
              )],
          ),
          body: SingleChildScrollView(
            child: Padding(
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
                          "Status ON:",
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Status OFF:",
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
                              color:
                              _offFlag == 1 ? Colors.red : Colors.grey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                              color: _lvFlag == 1
                                  ? Colors.orange
                                  : Colors.grey),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                              color:
                              _peError == 1 ? Colors.yellow : Colors.grey),
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
                      height: 170,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Rest Hour 1"),
                                  Center(child: Text("${_startTime1}"))
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
                                  Center(child: Text("${_startTime2}"))
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
                                  Text("[${_startCustomTime1}]"),
                                  Column(
                                    children: [
                                      Text("Hours"),
                                      Container(
                                          height: 30,
                                          width: 50,
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
                                  Column(
                                    children: [
                                      Text("Minutes"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        color: Colors.grey,
                                        child: TextFormField(
                                          controller: r1MinController,
                                          textAlign: TextAlign.center,
                                          cursorColor: Colors.white,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                  Text("[${_startCustomTime2}]"),
                                  Column(
                                    children: [
                                      Text("Hours"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        color: Colors.grey,
                                        child: TextFormField(
                                          controller: r2Controller,
                                          textAlign: TextAlign.center,
                                          cursorColor: Colors.white,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Minutes"),
                                      Container(
                                        height: 30,
                                        width: 50,
                                        color: Colors.grey,
                                        child: TextFormField(
                                          controller: r2MinController,
                                          textAlign: TextAlign.center,
                                          cursorColor: Colors.white,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: "",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                onPressed: () {

                                  if (r1Controller.text.isNotEmpty &&
                                      r2Controller.text.isNotEmpty) {
                                    InsertR1(r1Controller.text, r2Controller.text,r1MinController.text,r2MinController.text);
                                  }
                                  print("Values Written");
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
          ),
        ));
  }

  void InsertR1(String rest1, String rest2, String restMin1,String restMin2,) {
    databaseref.child('output').update({
      'Start_HourR1': rest1,
      'Start_HourR2': rest2,
      'Start_MinuteR1': restMin1,
      'Start_MinuteR2': restMin2
    });
    r1Controller.clear();
    r2Controller.clear();
    r1MinController.clear();
    r2MinController.clear();
  }
}
