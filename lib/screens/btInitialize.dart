import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:vitality/screens/connection.dart';
import 'package:vitality/screens/homescreen.dart';

class btInit extends StatelessWidget {
  final String docid;
  final bool isCaretaker;
  static const String id = 'btinit';
  btInit({@required this.docid, @required this.isCaretaker});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            print('bluetooth turned on');
            // return MyHomePage(title: 'Flutter Demo Home Page');
            return Home(docid: docid, isCaretaker: isCaretaker);
          } else {
            return Home(docid: docid, isCaretaker: isCaretaker);
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String docid;
  final bool isCaretaker;
  Home({this.docid, this.isCaretaker});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
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
        child: SelectBondedDevicePage(
          Upload: (device1) {
            BluetoothDevice device = device1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(
                    docid: docid,
                    isCaretaker: isCaretaker,
                    currentDevice: device,
                  );
                },
              ),
            );
          },
        ),
      ),
    ));
  }
}
