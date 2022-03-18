import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late DatabaseReference _dbref;
  late DatabaseReference _waterLevelRef;
  List<String> onStatusListName = [];
  List<String> offStatusListName = [];
  List<String> phaseListName = [];
  List<String> voltageListName = [];
  List<String> disconnectedDeviceName = [];
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
  List<int> _offStatus = [
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
  List<int> _offstatus = [
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
  List<int> _disconnected = [
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
  late List<dynamic> lowVoltageList = [];
  late List<dynamic> phaseErrorList = [];
  late List<dynamic> onStatusList = [];
  late List<dynamic> offStatusList = [];
  late List<dynamic> dsconnectedDeive = [];
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
  int totalDisconnected = 0;
  var _clarifierLevel;
  var _poonaLevel ;
  var percentagePoonaWater;
  var percentageClarifierWater;
  var poonaWaterLevel;
  var clarifierWaterLevel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _waterLevelRef = FirebaseDatabase(
            databaseURL: "https://iotwaterlevelindicator-938b6-default-rtdb.firebaseio.com/").reference().child('WaterTanks');
    _waterLevelRef.onValue.listen((event) {
      final waterData =
          Map<String, dynamic>.from(event.snapshot.value as dynamic);
      final clarifierLevel = waterData['Poona'];
      final ponnaLevel = waterData['Clarifier'];
      setState(() {
        _clarifierLevel = clarifierLevel;
        _poonaLevel = ponnaLevel;
        print("Value of Clarifier");
        print(_clarifierLevel);
        print(_poonaLevel);
      });
    });
    for (int i = 0; i <= 24; i++) {
      _dbref = FirebaseDatabase(databaseURL: dburl[i]).reference().child('Op');
      _dbref.child('input').onValue.listen((event) {
        final data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
        final onFlag = data['ON_Flag'];
        final lvFlag = data['LV_Flag'];
        final peError = data['FE_Flag'];
        final offFlag = data['OFF_Flag'];
        print(offFlag);
        setState(() {
          _status[i] = onFlag;
          _lowVoltage[i] = lvFlag;
          _phaseError[i] = peError;
          _offStatus[i] = offFlag;
          if (offFlag == 1) {
            _status[i] = 0;
            _lowVoltage[i] = 0;
            _phaseError[i] = 0;
            _offStatus[i] = offFlag;
            totalOff = totalOff + 1;
            offStatusList.add(data);
            offStatusListName.add("Tubewell NO. ${i + 1}");
            print("Total $totalOff");
          }
          if (onFlag == 1) {
            _status[i] = onFlag;
            _lowVoltage[i] = 0;
            _phaseError[i] = 0;
            _offStatus[i] = 0;
            totalOn = totalOn + 1;
            onStatusList.add(data);
            onStatusListName.add("Tubewell NO. ${i + 1}");
          }
          if (peError == 1 || lvFlag == 1) {
            _status[i] = 0;
            _lowVoltage[i] = lvFlag;
            _phaseError[i] = peError;
            _offStatus[i] = 0;
            totalError = totalError + 1;
            phaseErrorList.add(data);
            phaseListName.add("Tubewell NO. ${i + 1}");
          }
          /*
          if (lvFlag == 1) {
            _status[i] = 0;
            _lowVoltage[i] = lvFlag;
            _phaseError[i] = peError;
            _offStatus[i] = 0;
            totalPower = totalPower + 1;
            lowVoltageList.add(data);
            voltageListName.add("Tubewell NO. ${i + 1}");
          }*/
          print("Printing start here");
          print(onFlag);
          print(offFlag);
          print(peError);
          print(lvFlag);
          print("Printing End here");
          if (onFlag == 0 && offFlag == 0 && peError == 0 && lvFlag == 0) {
            print('inside');
            totalDisconnected = totalDisconnected + 1;
            dsconnectedDeive.add(data);
            disconnectedDeviceName.add("Tubewell No. ${i + 1}");
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        width: 170,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              totalOn.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total On",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: onStatusList.length,
                            itemBuilder: (context, index) {
                              print("inside item Builder");
                              print(
                                  '..........................${onStatusList[index]}');
                              final data1 = onStatusList[index] as dynamic;
                              var onFlag = data1['ON_Flag'];
                              var lvFlag = data1['LV_Flag'];
                              var peError = data1['FE_Flag'];
                              var offFlag = data1['OFF_Flag'];
                              if (onFlag == 1) {
                                lvFlag = 0;
                                peError = 0;
                                offFlag = 0;
                              }
                              return Row(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color.fromARGB(255, 2, 31, 102)),
                                    child: Column(
                                      children: [
                                        Text("${onStatusListName[index]}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status ON:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: onFlag == 1
                                                      ? Colors.green
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status OFF:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: offFlag == 1
                                                      ? Colors.red
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Low Voltage:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: lvFlag == 1
                                                      ? Colors.orange.shade900
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Phase Error:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: peError == 1
                                                      ? Colors.yellow
                                                      : Colors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                  )
                                ],
                              );
                            }),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        width: 170,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              totalOff.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total OFF",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: offStatusList.length,
                            itemBuilder: (context, index) {
                              print("inside item Builder");
                              final data1 = offStatusList[index] as dynamic;
                              var onFlag = data1['ON_Flag'];
                              var lvFlag = data1['LV_Flag'];
                              var peError = data1['FE_Flag'];
                              var offFlag = data1['OFF_Flag'];
                              if (offFlag == 1) {
                                onFlag = 0;
                                lvFlag = 0;
                                peError = 0;
                                print("Total $totalOff");
                              }
                              return Row(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color.fromARGB(255, 2, 31, 102)),
                                    child: Column(
                                      children: [
                                        Text("${offStatusListName[index]}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status ON:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: onFlag == 1
                                                      ? Colors.green
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status OFF:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: offFlag == 1
                                                      ? Colors.red
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Low Voltage:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: lvFlag == 1
                                                      ? Colors.orange.shade900
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Phase Error:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: peError == 1
                                                      ? Colors.yellow
                                                      : Colors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                  )
                                ],
                              );
                            }),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        width: 170,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              totalError.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total Phase Error",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: phaseErrorList.length,
                            itemBuilder: (context, index) {
                              print("inside item Builder");
                              final data1 = phaseErrorList[index] as dynamic;
                              var onFlag = data1['ON_Flag'];
                              var lvFlag = data1['LV_Flag'];
                              var peError = data1['FE_Flag'];
                              var offFlag = data1['OFF_Flag'];
                              if (peError == 1 || lvFlag == 1) {
                                onFlag = 0;
                                offFlag = 0;
                              }
                              return Row(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color.fromARGB(255, 2, 31, 102)),
                                    child: Column(
                                      children: [
                                        Text("${phaseListName[index]}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status ON:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: onFlag == 1
                                                      ? Colors.green
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status OFF:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: offFlag == 1
                                                      ? Colors.red
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Low Voltage:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: lvFlag == 1
                                                      ? Colors.orange.shade900
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Phase Error:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: peError == 1
                                                      ? Colors.yellow
                                                      : Colors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                  )
                                ],
                              );
                            }),
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 200,
                        width: 170,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              totalDisconnected.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total Disconnected",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dsconnectedDeive.length,
                            itemBuilder: (context, index) {
                              print("inside item Builder");
                              final data1 = dsconnectedDeive[index] as dynamic;
                              var onFlag = data1['ON_Flag'];
                              var lvFlag = data1['LV_Flag'];
                              var peError = data1['FE_Flag'];
                              return Row(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Color.fromARGB(255, 2, 31, 102)),
                                    child: Column(
                                      children: [
                                        Text(
                                            "${disconnectedDeviceName[index]}"),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status ON:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: onFlag == 1
                                                      ? Colors.green
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Status OFF:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _offstatus == 1
                                                      ? Colors.green
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Low Voltage:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: lvFlag == 1
                                                      ? Colors.orange.shade900
                                                      : Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Phase Error:",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: peError == 1
                                                      ? Colors.yellow
                                                      : Colors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white,
                                  )
                                ],
                              );
                            }),
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "WaterTank Level",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text("Poona Tank"),
                      SizedBox(
                          height: 180,
                          width: 170,
                          child: LiquidLinearProgressIndicator(
                            value: _poonaLevel,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                            backgroundColor: Colors.white,
                            // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.black,
                            borderWidth: 5.0,
                            borderRadius: 12.0,
                            direction: Axis.vertical,
                            center: Text("${_poonaLevel*100.toInt()}%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 25),
                            ), //text inside bar
                          )),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text("Charifier Tank"),
                      SizedBox(
                          height: 180,
                          width: 170,
                          child: LiquidLinearProgressIndicator(
                            value: _clarifierLevel,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                            backgroundColor: Colors.white,
                            // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.black,
                            borderWidth: 5.0,
                            borderRadius: 12.0,
                            direction: Axis.vertical,
                            center: Text("${_clarifierLevel*100.toInt()}%",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 25),
                            ), //text inside bar
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
