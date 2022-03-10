import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class WriteData extends StatefulWidget {
  const WriteData({Key? key}) : super(key: key);

  @override
  _WriteDataState createState() => _WriteDataState();
}

class _WriteDataState extends State<WriteData> {
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('/dailySpecial');
    return Scaffold(
      appBar: AppBar(
        title: Text("Writing Data on Firebase"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    dailySpecialRef
                        .set({'description': 'Vanilla Leetee', 'price': 4.99})
                        .then((_) => print(""))
                        .catchError((error) => print("$error"));
                  },
                  child: Text("Insert Data"))
            ],
          ),
        ),
      ),
    );
  }
}
