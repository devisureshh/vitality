import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitality/components/button.dart';
import 'package:geocoder/geocoder.dart';
import 'package:vitality/screens/login.dart';
import 'dart:async';

final auth = FirebaseAuth.instance;
String elderly;
int phone;
String caretaker;
String carepass;
String carepass2;
String address;
int radius;
var docid;
List<int> radiuses = [1, 2, 3, 5, 7, 10, 15, 20]; // Option 2
int selectedradius;
CollectionReference main = FirebaseFirestore.instance.collection('maindb');

Future<void> addData(uid) async {
  var addresses = await Geocoder.local.findAddressesFromQuery(address);
  var first = addresses.first;
  print(addresses.first.coordinates.latitude);
  print(addresses.first.coordinates.longitude);
  double lat = first.coordinates.latitude;
  double long = first.coordinates.longitude;

  Map<String, dynamic> data = {
    'caretaker': caretaker,
    'elderly': elderly,
    'pulse': 66,
    'temperature': 32,
    'lat': lat,
    'longitude': long,
    'radius': selectedradius,
    'phone': phone
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
                    SizedBox(height: 55.0),
                    Text('INFIRM',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3),
                    SizedBox(height: 15.0),
                    Text('USERNAME',
                        style: Theme.of(context).textTheme.headline3),
                    TextField(
                      onChanged: (value) {
                        elderly = value;
                      },
                    ),
                    SizedBox(height: 75.0),
                    Text('CARETAKER',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 15.0),
                    Text('USERNAME',
                        style: Theme.of(context).textTheme.headline3),
                    TextField(
                      onChanged: (value) {
                        caretaker = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text('PASSWORD',
                        style: Theme.of(context).textTheme.headline3),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        carepass = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text('CONFIRM PASSWORD',
                        style: Theme.of(context).textTheme.headline3),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        carepass2 = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text('PHONE NUMBER',
                        style: Theme.of(context).textTheme.headline3),
                    TextField(
                      onChanged: (value) {
                        phone = int.parse(value);
                      },
                    ),
                    SizedBox(height: 15),
                    Text('HOME ADDRESS',
                        style: Theme.of(context).textTheme.headline3),
                    TextField(
                      onChanged: (value) {
                        address = value;
                      },
                    ),
                    SizedBox(height: 15.0),
                    Text('RADIUS',
                        style: Theme.of(context).textTheme.headline3),
                    DropdownButton(
                      hint: Text('Please choose a radius'),
                      value: selectedradius,
                      onChanged: (newValue) {
                        setState(() {
                          selectedradius = newValue;
                        });
                      },
                      items: radiuses.map((radius) {
                        return DropdownMenuItem(
                          child: new Text(radius.toString()),
                          value: radius,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(height: 55.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 200.0, height: 40),
                      child: Button(
                        text: 'REGISTER',
                        onPressed: () async {
                          if (carepass == carepass2) {
                            try {
                              final newUser =
                                  await auth.createUserWithEmailAndPassword(
                                      email: caretaker, password: carepass);
                              addData(auth.currentUser.uid);
                            } catch (e) {
                              print(e);
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return AlertDialog(
                                    title: Text('PASSWORDS DO NOT MATCH',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 200.0, height: 40),
                      child: Button(
                          text: 'GO TO LOGIN',
                          onPressed: () async {
                            await doesElderlyExist();
                            print('docid:$docid');
                            if (docid != null) {
                              Navigator.pushNamed(context, LoginScreen.id);
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
