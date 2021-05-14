import 'package:flutter/material.dart';
import '../components/biom.dart';
import 'package:vitality/components/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  var pulse;
  var temp;
  @override
  Widget build(BuildContext context) {
    print('got here');
    print(auth.currentUser.uid);
    String id = ModalRoute.of(context).settings.arguments;
    //String docID = auth.currentUser.uid;
    CollectionReference main = FirebaseFirestore.instance.collection('maindb');
    main.doc(id).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        //print(documentSnapshot['pulse']);
        pulse = documentSnapshot['pulse'];
        temp = documentSnapshot['temperature'];
      }
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF602247),
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'VITALITY',
            style: Theme.of(context).textTheme.headline4,
          )),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage('https://wallpaperaccess.com/full/1549296.jpg'),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(.7), BlendMode.dstATop),
        )),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(id),
              //Text(person['iscare']),
              biom(image: 'pulse', number: pulse),
              Text('PULSE', style: Theme.of(context).textTheme.headline1),
              biom(image: 'temper', number: temp),
              Text('TEMPERATURE', style: Theme.of(context).textTheme.headline1),
              SizedBox(height: 20.0),
            ]),
      ),
      bottomNavigationBar: bottomAppBar(id: id),
    );
  }
}
