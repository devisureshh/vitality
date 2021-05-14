import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'screens/homescreen.dart';
import 'components/button.dart';

class Details extends StatefulWidget {
  final String elderly;
  final String id;
  final DocumentSnapshot documentSnapshot;
  Details({this.documentSnapshot, this.elderly, this.id});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Button(
        text: 'Test',
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.id, arguments: widget.id);
        });
  }
}
