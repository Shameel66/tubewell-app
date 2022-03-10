import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:tubewell_app/view/allTab.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late DatabaseReference _dbref;
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
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Total Tubewells On",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      totalOn.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      "Total Tubewells Off",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      totalOff.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Tubewells  in Eror/Fault",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      totalError.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      "Tubewells having\n Power Breakdown",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      totalPower.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
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
            SizedBox(
                height: 200,
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
    );
  }
}

