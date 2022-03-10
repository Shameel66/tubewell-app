import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class TubeWell7 extends StatefulWidget {
  @override
  _TubeWell7State createState() => _TubeWell7State();
}

class _TubeWell7State extends State<TubeWell7> {
  late DatabaseReference _schedule;
  bool switchValue = false;
  int _onFlag = 0;
  var _lvFlag = 0;
  var _peError = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _schedule = FirebaseDatabase(databaseURL: 'https://tubewell7-5a8a9-default-rtdb.asia-southeast1.firebasedatabase.app/').reference().child('Op');
    _schedule.child('output').onValue.listen((event) {
      final time = Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final startTime1 = "${time['Start_HourR1']}";
      final startTime2 = "${time['Start_HourR2']}";

      setState(() {
        _startTime1 = startTime1;
        _startTime2 = startTime2;
      });
    });
     _schedule.child('input').onValue.listen((event) {
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
  final databaseref = FirebaseDatabase(databaseURL: "https://tubewell7-5a8a9-default-rtdb.asia-southeast1.firebasedatabase.app/").reference().child("Op");
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
            title: Text("Tubewell NO.7"),
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
        ));
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
