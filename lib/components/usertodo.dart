import 'package:flutter/material.dart';

String string1;

class userTodo extends StatefulWidget {
  final Map data;
  userTodo({this.data});
  @override
  _userTodoState createState() => _userTodoState();
}

class _userTodoState extends State<userTodo> {
  // makeString(data) {
  //   int count = 2;
  //   for (int i = 0; i < 2; i++) {
  //     string1 = data['task1'];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    bool _checked = true;
    return CheckboxListTile(
      title: Text(string1),
      value: _checked,
      onChanged: (bool value) {
        print('changed');
      },
      secondary: const Icon(Icons.hourglass_empty),
    );
  }
}
