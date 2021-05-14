import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitality/screens/homescreen.dart';
import 'package:vitality/components/button.dart';

bool isCaretaker = false;
String elderly;
String caretaker;
String carepass;
var docid;
CollectionReference main = FirebaseFirestore.instance.collection('maindb');

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static const String id = 'login_screen';
}

// class arguments {
//   String id;
//   bool isCare= false;
//   arguments({this.id,this.isCare})
//   }
doesCTExist() async {
  print('in does caretaker exist');
  main.where('caretaker', isEqualTo: caretaker).get().then(
        (QuerySnapshot snapshot) => {
          snapshot.docs.forEach((f) {
            docid = f.reference.id;
          }),
        },
      );
  print('docid in caretaker function: $docid');
}

doesElderlyExist() async {
  print('in does elderly exist');
  print(elderly);
  main.where('elderly', isEqualTo: elderly).get().then(
        (QuerySnapshot snapshot) => {
          snapshot.docs.forEach((f) {
            docid = f.reference.id;
          }),
        },
      );
  print('docid in elderly function: $docid');
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF602247),
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'VITALITY',
            style: Theme.of(context).textTheme.headline4,
          )),
      backgroundColor: Colors.white,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.fonewalls.com/wp-content/uploads/2019/10/Gradient-Background-Wallpaper-002-300x585.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.7), BlendMode.dstATop),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DelayedDisplay(
                  delay: Duration(seconds: 1),
                  child: Column(children: <Widget>[
                    SizedBox(height: 90),
                    Text('INFIRM LOGIN',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 15.0),
                    Text('USERNAME',
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(height: 15.0),
                    TextField(
                      onChanged: (value) {
                        elderly = value;
                      },
                    ),
                    SizedBox(height: 25.0),
                    Button(
                        text: 'LOGIN AS INFIRM ',
                        onPressed: () {
                          doesElderlyExist();
                          print('docid after elderly function call: $docid');
                          if (docid == null) {
                            print('user does not exist');
                          } else {
                            //+arguments person = arguments(id :docid,isCare:true);
                            Navigator.pushNamed(context, HomeScreen.id,
                                arguments: docid);
                          }
                        }),
                    SizedBox(height: 95.0),
                    Text('CARETAKER LOGIN',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 15.0),
                    Text('USERNAME',
                        style: Theme.of(context).textTheme.headline1),
                    TextField(
                      onChanged: (value) {
                        caretaker = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text('PASSWORD',
                        style: Theme.of(context).textTheme.headline1),
                    TextField(
                      onChanged: (value) {
                        carepass = value;
                      },
                    ),
                    SizedBox(height: 25.0),
                    Button(
                      text: 'LOGIN AS CARETAKER',
                      onPressed: () async {
                        try {
                          doesCTExist();
                          print('docid after ct function call: $docid');
                          final user = await _auth.signInWithEmailAndPassword(
                              email: caretaker, password: carepass);
                          if (user != null) {
                            isCaretaker = true;
                            Navigator.pushNamed(context, HomeScreen.id,
                                arguments: docid);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}