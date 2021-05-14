import 'dart:ui';
import 'package:vitality/stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vitality/screens/login.dart';
import 'screens/homescreen.dart';
import 'screens/chatbot.dart';
import 'screens/todo.dart';
import 'package:vitality/screens/welcome.dart';
import 'screens/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Welcome.id:
        return MaterialPageRoute(builder: (_) => Welcome());
    }
  }
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
              fontSize: 15.0, fontFamily: 'Montserrat', color: Colors.black),
          headline2: TextStyle(
              fontSize: 60.0, fontFamily: 'CrimsonText', color: Colors.black),
          headline3: TextStyle(
              fontSize: 30.0, fontFamily: 'Lora', color: Colors.white),
          headline4: TextStyle(
              fontSize: 30.0, fontFamily: 'Montserrat', color: Colors.white),
        ),
      ),
      initialRoute: Welcome.id,
      routes: {
        'test': (context) => Test(),
        Welcome.id: (context) => Welcome(),
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        Register.id: (context) => Register(),
        ChatBot.id: (context) => ChatBot(),
        Todo.id: (context) => Todo()
      },
    );
  }
}
