import 'package:family_member/Screens/HomePage.dart';
import 'package:family_member/Screens/SplashScreen.dart';
import 'package:family_member/Screens/add_member_screen.dart';
import 'package:family_member/Screens/family_details.dart';
import 'package:family_member/Screens/loginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SplashScreen2(
    key: UniqueKey(),
    onInitializationComplete: () => runApp(MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connecle',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
