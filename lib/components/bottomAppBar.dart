import 'package:flutter/material.dart';
import 'package:vitality/screens/login.dart';
import 'package:vitality/screens/todo.dart';
import 'package:vitality/screens/chatbot.dart';
import 'package:vitality/screens/homescreen.dart';
import 'package:vitality/components/ScreenArguments.dart';

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
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.list),
              color: Colors.white,
              onPressed: () {
                print(widget.id);
                print(isCaretaker.toString());
                Navigator.of(context).pushNamed('todoscreen',
                    arguments: ScreenArguments(
                        docid: widget.id, isCaretaker: isCaretaker));
              }),
          IconButton(
              icon: Icon(Icons.data_usage),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('home_screen',
                    arguments: ScreenArguments(
                        docid: widget.id, isCaretaker: isCaretaker));
              }),
          IconButton(
              icon: Icon(Icons.chat),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('chat_screen',
                    arguments: ScreenArguments(
                        docid: widget.id, isCaretaker: isCaretaker));
              }),
        ],
      ),
    );
  }
}
