import 'package:flutter/material.dart';
import 'package:vitality/screens/login.dart';
import 'package:vitality/components/ScreenArguments.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class bottomAppBar extends StatefulWidget {
  final BluetoothDevice currentDevice;
  final String id;
  bottomAppBar({this.id, this.currentDevice});
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
                print('to do pressed');
                print(docid);
                print(isCaretaker.toString());
                Navigator.of(context).pushNamed('todoscreen',
                    arguments: ScreenArguments(
                        docid: docid,
                        isCaretaker: isCaretaker,
                        currentDevice: widget.currentDevice));
              }),
          IconButton(
              icon: Icon(Icons.data_usage),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('home_screen',
                    arguments: ScreenArguments(
                        docid: widget.id,
                        isCaretaker: isCaretaker,
                        currentDevice: widget.currentDevice));
              }),
          IconButton(
              icon: Icon(Icons.chat),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushNamed('chat_screen',
                    arguments: ScreenArguments(
                        docid: widget.id,
                        isCaretaker: isCaretaker,
                        currentDevice: widget.currentDevice));
              }),
        ],
      ),
    );
  }
}
