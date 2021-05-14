import 'package:flutter/material.dart';
import 'package:vitality/components/bottomAppBar.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
  static const String id = 'chat_screen';
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'VITALITY',
            style: Theme.of(context).textTheme.headline3,
          )),
      bottomNavigationBar: bottomAppBar(),
    );
  }
}
