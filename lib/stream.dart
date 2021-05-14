import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'details.dart';
import 'dart:async';

final _auth = FirebaseAuth.instance;
String elderly;
String caretaker;
String carepass;
var docid;

Future<void> addData() async {
  Map<String, dynamic> data = {
    'caretaker': caretaker,
    'elderly': elderly,
    'pulse': 66,
    'temperature': 99
  };
  await main.add(data);
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

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

CollectionReference main = FirebaseFirestore.instance.collection("maindb");

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("maindb").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Details(
                      documentSnapshot: data,
                      elderly: data['elderly'],
                      id: data.id,
                    );
                  },
                );
        },
      ),
    );
  }
}
