import 'package:flutter/material.dart';
import 'package:vitality/components/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitality/components/usertodo.dart';

final auth = FirebaseAuth.instance;

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
  static const String id = 'todoscreen';
}

class _TodoState extends State<Todo> {
  CollectionReference todo = FirebaseFirestore.instance.collection('todo');
  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context).settings.arguments;
    print('uid in todo is $uid');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF602247),
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'VITALITY',
            style: Theme.of(context).textTheme.headline3,
          ),
          automaticallyImplyLeading: false,
          actions: [
            Icon(Icons.add),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage('https://wallpaperaccess.com/full/1549296.jpg'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(.7), BlendMode.dstATop),
          )),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(uid),
                Container(
                  height: 700,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('todo')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return FutureBuilder<DocumentSnapshot>(
                          future: todo.doc(auth.currentUser.uid).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.hasData && !snapshot.data.exists) {
                              return Container(child: Text("No todos"));
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data = snapshot.data.data();
                              return Text('got it');
                            }

                            return Text("loading");
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomAppBar(id: uid));
  }
}
