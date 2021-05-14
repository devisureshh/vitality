import 'package:flutter/material.dart';
import 'package:vitality/screens/todo.dart';
import 'package:vitality/screens/chatbot.dart';
import 'package:vitality/screens/homescreen.dart';

class bottomAppBar extends StatefulWidget {
  final String id;
  bottomAppBar({this.id});
  @override
  _bottomAppBarState createState() => _bottomAppBarState();
}

class _bottomAppBarState extends State<bottomAppBar> {
  @override
  Widget build(BuildContext context) {
    print('id in bottom is ${widget.id}');
    return BottomAppBar(
      color: Color(0xFF602247),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.list),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, Todo.id, arguments: widget.id);
              }),
          IconButton(
              icon: Icon(Icons.data_usage),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.id);
              }),
          IconButton(
              icon: Icon(Icons.chat),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, ChatBot.id);
              }),
        ],
      ),
    );
  }
}
