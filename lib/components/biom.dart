import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';

CollectionReference main = FirebaseFirestore.instance.collection('maindb');

class biom extends StatefulWidget {
  biom({this.which, this.image, this.docid});
  final String which;
  final String docid;
  final String image;

  @override
  _biomState createState() => _biomState();
}

_callNumber() async {
  const number = '8606535166'; //set the number here
  bool res = await FlutterPhoneDirectCaller.callNumber(number);
}

class _biomState extends State<biom> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('images/${widget.image}.png',
                height: 100.0, width: 100.0),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('maindb')
                    .doc(widget.docid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  }
                  var userDocument = snapshot.data;
                  if (userDocument["${widget.which}"] > 70) {
                    _callNumber();
                    print(
                        'calling because ${userDocument["${widget.which}"]} is greater than 70');
                  }
                  return CircleWidget(num: userDocument["${widget.which}"]);
                })
          ],
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final int num;
  CircleWidget({this.num});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 200.0,
      padding: const EdgeInsets.symmetric(),
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0))),
      child: Center(
        child:
            Text(num.toString(), style: Theme.of(context).textTheme.headline5),
      ),
    );
  }
}
