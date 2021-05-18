import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitality/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vitality/components/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff222831),
        accentColor: Color(0xff00adb5),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 25.0, fontFamily: 'Montserrat', color: Colors.black),
          headline2: TextStyle(
              fontSize: 60.0, fontFamily: 'CrimsonText', color: Colors.black),
          headline3: TextStyle(
              fontSize: 30.0, fontFamily: 'Lora', color: Colors.white),
          headline4: TextStyle(
              fontSize: 30.0, fontFamily: 'Montserrat', color: Colors.white),
          headline5: TextStyle(
              fontSize: 85.0, fontFamily: 'Montserrat', color: Colors.black),
          headline6: TextStyle(
              fontSize: 20.0, fontFamily: 'Montserrat', color: Colors.white),
        ),
      ),
      initialRoute: Welcome.id,
      onGenerateRoute: RouteGen.generateRoute,
    );
  }
}
