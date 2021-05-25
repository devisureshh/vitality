import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vitality/screens/login.dart';
import 'package:vitality/screens/homescreen.dart';
import 'package:vitality/screens/chatbot.dart';
import 'package:vitality/screens/todo.dart';
import 'package:vitality/screens/welcome.dart';
import 'package:vitality/screens/register.dart';
import 'package:vitality/components/ScreenArguments.dart';
import 'package:vitality/screens/btInitialize.dart';
import 'package:vitality/components/HomeArguments.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case btInit.id:
        return MaterialPageRoute(builder: (BuildContext context) {
          final argument = args as ScreenArguments;
          return btInit(
            docid: argument.docid,
            isCaretaker: argument.isCaretaker,
          );
        });
      case Welcome.id:
        return MaterialPageRoute(builder: (_) => Welcome());
      case HomeScreen.id:
        return MaterialPageRoute(builder: (BuildContext context) {
          final argument = args as ScreenArguments;
          return HomeScreen(
              docid: argument.docid,
              isCaretaker: argument.isCaretaker,
              currentDevice: argument.currentDevice);
        });
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Register.id:
        return MaterialPageRoute(builder: (_) => Register());
      case ChatBot.id:
        return MaterialPageRoute(builder: (BuildContext context) {
          final argument = args as ScreenArguments;
          return ChatBot(
              docid: argument.docid,
              isCaretaker: argument.isCaretaker,
              currentDevice: argument.currentDevice);
        });
      case Todo.id:
        return MaterialPageRoute(builder: (BuildContext context) {
          final argument = args as ScreenArguments;
          return Todo(
              docid: argument.docid,
              isCaretaker: argument.isCaretaker,
              currentDevice: argument.currentDevice);
        });
    }
  }
}
