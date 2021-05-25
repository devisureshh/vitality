import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:vitality/components/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitality/components/biom.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final String docid;
  final bool isCaretaker;
  final BluetoothDevice currentDevice;
  HomeScreen(
      {@required this.docid, @required this.isCaretaker, this.currentDevice});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

_callNumber() async {
  const number = '8606535166'; //set the number here
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  var pulse;
  var temp;
  static final clientID = 0;
  BluetoothConnection connection;
  String _messageBuffer = '';
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;
  @override
  void initState() {
    if (widget.isCaretaker == false) {
      super.initState();
      BluetoothConnection.toAddress(widget.currentDevice.address)
          .then((_connection) {
        print('Connected to the device');
        print('device is ${widget.currentDevice}');
        connection = _connection;
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });
        connection.input.listen(_onDataReceived).onDone(() {
          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            setState(() {});
          }
        });
      }).catchError((error) {
        print('Cannot connect, exception occurred');
        print(error);
      });
    }
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    print('$dataString');
    changePulse(int.parse(dataString));
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        _messageBuffer = dataString.substring(index);
        //print('In message buffer is $_messageBuffer');
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  changePulse(int dataString) {
    main
        .doc(widget.docid)
        .update({'pulse': dataString})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    print(
        'in homescreen each iis ${widget.docid}, ${widget.isCaretaker},${widget.currentDevice}');
    if (widget.isCaretaker == false) {
      _sendMessage('1');
    }
    print('got here');
    CollectionReference main = FirebaseFirestore.instance.collection('maindb');
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'HEALTH TRACKER',
            style: Theme.of(context).textTheme.headline4,
          )),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.setaswall.com/wp-content/uploads/2017/06/Blur-Phone-Wallpaper-1080x2340-011-340x550.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(.7), BlendMode.dstATop),
        )),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 100.0),
              Text(widget.docid),
              Text({widget.isCaretaker}.toString()),
              biom(which: 'pulse', image: 'pulse', docid: widget.docid),
              RoundBorderText(text: 'PULSE'),
              biom(which: 'temperature', image: 'temper', docid: widget.docid),
              RoundBorderText(text: 'TEMPERATURE'),
              SizedBox(height: 30.0),
              FlatButton(
                  child: Text('test call'),
                  onPressed: () async {
                    _callNumber();
                  })
            ]),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'https://www.setaswall.com/wp-content/uploads/2017/06/Blur-Phone-Wallpaper-1080x2340-011-340x550.jpg'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(1), BlendMode.dstATop),
          )),
          child: bottomAppBar(
              id: widget.docid, currentDevice: widget.currentDevice)),
    );
  }
}

class RoundBorderText extends StatelessWidget {
  final String text;
  RoundBorderText({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            left: 40.0, right: 40.0, top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
            // ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(text, style: Theme.of(context).textTheme.headline1));
  }
}
