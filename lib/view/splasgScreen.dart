import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tubewell_app/myBottomBar/bottomBar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BottomBar())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset("assets/images/cdaLogo.png",height: 150,),
            SizedBox(
              height: 50,
            ),

            Text(
              "CDA Tubewell",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              "Automation",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Text(
              "Application",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Powered By DeepAI",
                style: TextStyle(color: Colors.deepPurple, fontSize: 20),
              ),
            )),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
