import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  late DatabaseReference _dbref;
  bool switchValue = false;
  List<int> _status = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<int> _lowVoltage = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<int> _phaseError = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  List<String> dburl = [
    "https://tubewell1-a9fb4-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell2-2d36e-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell3-322c1-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell4-c99cf-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell5-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell6-d9d0d-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell7-5a8a9-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell8-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell9-107b4-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell10-29d0a-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell11-5c37f-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://demotocheck-d7f3c-default-rtdb.firebaseio.com/",
    "https://tubewell13-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell14-46b8f-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell15-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell16-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell17-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell18-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell19-4a419-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell20-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell21-7099d-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell22-759f4-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell23-e5a11-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell24-5d5df-default-rtdb.asia-southeast1.firebasedatabase.app/",
    "https://tubewell25-f3cbf-default-rtdb.asia-southeast1.firebasedatabase.app/"
  ];
  int totalOn = 0;
  int totalOff = 0;
  int totalError = 0;
  int totalPower = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i <= 24; i++) {
      _dbref = FirebaseDatabase(databaseURL: dburl[i]).reference().child('Op');
      _dbref.child('input').onValue.listen((event) {
        final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
        final onFlag = data['ON_Flag'];
        final lvFlag = data['LV_Flag'];
        final peError = data['FE_Flag'];
        setState(() {
          _status[i] = onFlag;
          _lowVoltage[i] = lvFlag;
          _phaseError[i] = peError;
          if (_status[i] == 0) {
            totalOff = totalOff + 1;
            print("Total $totalOff");
          }
          if (_status[i] == 1) {
            totalOn = totalOn + 1;
          }
          if (_phaseError[i] == 1) {
            totalError = totalError + 1;
          }
          if (_lowVoltage[i] == 1) {
            totalPower = totalPower + 1;
          }
        });
      });
    }
    totalStatus.totalPower = totalPower;
    totalStatus.totalOn = totalOn;
    totalStatus.totalOff = totalOff;
    totalStatus.totalError = totalError;
    print(totalError);
    print(totalPower);
    print(totalOn);
    print(totalOff);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All TubeWell"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 120,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 2, 31, 102)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Phase Error",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _phaseError[index] == 1
                                    ? Colors.green
                                    : Colors.red),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Low Voltage",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _lowVoltage[index] == 1
                                    ? Colors.green
                                    : Colors.red),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _status[index] == 1
                                    ? Colors.green
                                    : Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 120,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 2, 31, 102)),
                  child: Center(
                      child: Text(
                    "TubeWell ${index + 1}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  getValues(int index) {
    print("Get");
  }

  showValues() {
    setState(() {
      print("Show Values");
    });
  }
}

class totalStatus {
  static int? totalOn = 0;
  static int? totalOff = 0;
  static int? totalError = 0;
  static int? totalPower = 0;

  totalStatus();
}
