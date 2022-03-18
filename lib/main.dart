import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tubewell_app/theme/theme.dart';
import 'package:tubewell_app/view/splasgScreen.dart';



import 'myBottomBar/bottomBar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Tubewell1',
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDgTCS5WE7pb6l7-WDVWJLISP6v07RdLxY',
        appId: '1:316715827976:android:ecdbeca3e3339fffd1e2bd',
        messagingSenderId: '',
        projectId: 'tubewell1-a9fb4',
        storageBucket: 'tubewell1-a9fb4.appspot.com',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeClass.darkTheme,
      theme: ThemeClass.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
