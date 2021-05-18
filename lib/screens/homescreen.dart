import 'package:flutter/material.dart';
import 'package:vitality/components/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitality/components/biom.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final String docid;
  final bool isCaretaker;
  HomeScreen({@required this.docid, @required this.isCaretaker});
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
  @override
  Widget build(BuildContext context) {
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
          child: bottomAppBar(id: widget.docid)),
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
            // border: Border.all(
            //   color: Colors.black,
            //   width: 1.0,
            // ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(text, style: Theme.of(context).textTheme.headline1));
  }
}
