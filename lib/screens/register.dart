import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitality/components/button.dart';
import 'package:vitality/screens/homescreen.dart';
import 'dart:async';

final auth = FirebaseAuth.instance;
String elderly;
String caretaker;
String carepass;
var docid;
CollectionReference main = FirebaseFirestore.instance.collection('maindb');

// void aStream() async {
//   await for (var snapshot
//       in FirebaseFirestore.instance.collection('maindb').snapshots()) {
//     for(var message in snapshot.documents){
//       print(message.elderly)
//     }
//   }
// }

Future<void> addData(uid) async {
  Map<String, dynamic> data = {
    'caretaker': caretaker,
    'elderly': elderly,
    'pulse': 66,
    'temperature': 99
  };
  await main.doc(uid).set(data);
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
  static const String id = 'register_screen';
}

doesElderlyExist() async {
  print('elderly is $elderly');
  main.where('elderly', isEqualTo: elderly).get().then(
        (QuerySnapshot snapshot) => {
          snapshot.docs.forEach((f) {
            docid = f.reference.id;
          }),
        },
      );
  print('docid after searching :$docid');
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 50.0,
          flexibleSpace: Image(
            image: NetworkImage(
                'https://www.setaswall.com/wp-content/uploads/2017/06/Blur-Phone-Wallpaper-1080x2340-011-340x550.jpg'),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          title: Text(
            'REGISTER',
            style: Theme.of(context).textTheme.headline4,
          )),
      backgroundColor: Colors.white,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(
              'https://www.setaswall.com/wp-content/uploads/2017/06/Blur-Phone-Wallpaper-1080x2340-011-340x550.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.65), BlendMode.dstATop),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DelayedDisplay(
                  delay: Duration(seconds: 1),
                  child: Column(children: <Widget>[
                    SizedBox(height: 85.0),
                    Text('INFIRM SETUP',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 15.0),
                    Text('USERNAME',
                        style: Theme.of(context).textTheme.headline1),
                    TextField(
                      onChanged: (value) {
                        elderly = value;
                      },
                    ),
                    SizedBox(height: 75.0),
                    Text('CARETAKER SETUP',
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
                    SizedBox(height: 15.0),
                    Text('CONFIRM PASSWORD',
                        style: Theme.of(context).textTheme.headline1),
                    TextField(
                      onChanged: (value) {
                        carepass = value;
                      },
                    ),
                    SizedBox(height: 55.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 200.0, height: 40),
                      child: Button(
                        text: 'REGISTER',
                        onPressed: () async {
                          try {
                            final newUser =
                                await auth.createUserWithEmailAndPassword(
                                    email: caretaker, password: carepass);
                            addData(auth.currentUser.uid);
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 200.0, height: 40),
                      child: Button(
                          text: 'ENTER APP',
                          onPressed: () async {
                            await doesElderlyExist();
                            print('docid:$docid');
                            if (docid != null) {
                              Navigator.pushNamed(context, HomeScreen.id,
                                  arguments: docid);
                            }
                          }),
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
