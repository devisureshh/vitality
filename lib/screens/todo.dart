import 'package:flutter/material.dart';
import 'package:vitality/components/bottomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitality/screens/login.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

bool temp;
var todoid;
int number = 0;
final auth = FirebaseAuth.instance;
Stream collectionStream =
    FirebaseFirestore.instance.collection('todo').snapshots();
CollectionReference main = FirebaseFirestore.instance.collection('maindb');
CollectionReference todo = FirebaseFirestore.instance.collection('todo');
TextEditingController myController = TextEditingController();

class Todo extends StatefulWidget {
  final String docid;
  final bool isCaretaker;
  final BluetoothDevice currentDevice;
  Todo({this.docid, this.isCaretaker, this.currentDevice});
  @override
  _TodoState createState() => _TodoState();
  static const String id = 'todoscreen';
}

Future<void> addTask(String task) async {
  Map<String, dynamic> data = {
    'task_id': number,
    'user_id': docid,
    'task': task,
    'done': false
  };
  await todo.add(data);
  number++;
}

Future<void> invertDone(String task) async {
  todo.where('task', isEqualTo: task).get().then(
        (QuerySnapshot snapshot) => {
          snapshot.docs.forEach((f) {
            todoid = f.reference;
            print('todoid found is $todoid');
            FirebaseFirestore.instance
                .runTransaction((transaction) async {
                  print('in here');
                  DocumentSnapshot snapshot = await transaction.get(todoid);
                  if (!snapshot.exists) {
                    throw Exception("User does not exist!");
                  }
                  print(snapshot.data()['done']);
                  temp = snapshot.data()['done'];
                  print('it was $temp');
                  temp = !temp;
                  print('now its $temp');
                  transaction.update(todoid, {'done': temp});
                })
                .then((value) => print("data updated"))
                .catchError((error) => print("Failed to update : $error"));
          }),
        },
      );
}

deleteTask(context, String task) {
  Alert(
      context: context,
      title: "DELETE TASK?",
      style: AlertStyle(titleStyle: Theme.of(context).textTheme.headline1),
      buttons: [
        DialogButton(
          color: Colors.blue.shade200,
          onPressed: () {
            print('delete pressed');
            todo
                .where('task', isEqualTo: task)
                .get()
                .then((QuerySnapshot snapshot) => {
                      snapshot.docs.forEach((f) {
                        todoid = f.reference.id;
                        print('todoid found is $todoid');
                        todo
                            .doc(todoid)
                            .delete()
                            .then((value) => print("TAsk Deleted"))
                            .catchError((error) =>
                                print("Failed to delete task: $error"));
                      })
                    });
            Navigator.pop(context);
            myController.clear();
          },
          child: Text(
            "DELETE",
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ]).show();
}

_openPopup(context) {
  Alert(
      context: context,
      title: "Add Todo",
      style: AlertStyle(titleStyle: Theme.of(context).textTheme.headline1),
      content: Column(children: <Widget>[
        TextField(
          controller: myController,
          decoration: InputDecoration(
            icon: Icon(Icons.check),
            labelText: 'Task',
            labelStyle: Theme.of(context).textTheme.headline1,
          ),
        ),
      ]),
      buttons: [
        DialogButton(
          color: Colors.transparent,
          onPressed: () {
            addTask(myController.text);
            Navigator.pop(context);
            myController.clear();
            //print(myController.text);
          },
          child: Text(
            "ADD TASK",
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ]).show();
}

class _TodoState extends State<Todo> {
  // @override
  // void dispose() {
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF602247),
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'REMINDERS',
            style: Theme.of(context).textTheme.headline4,
          ),
          automaticallyImplyLeading: false,
          flexibleSpace: Image(
            image: NetworkImage(
                'https://www.setaswall.com/wp-content/uploads/2017/06/Blur-Phone-Wallpaper-1080x2340-011-340x550.jpg'),
            fit: BoxFit.cover,
          ),
          actions: [
            Visibility(
                visible: isCaretaker,
                child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white, size: 30.0),
                    onPressed: () {
                      _openPopup(context);
                    })),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'https://www.setaswall.com/wp-content/uploads/2017/06/Blur-Phone-Wallpaper-1080x2340-011-340x550.jpg'),
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(.6), BlendMode.dstATop),
          )),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('todo')
                .where('user_id', isEqualTo: docid)
                .snapshots(),
            builder: (context, snapshot) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot task = snapshot.data.docs[index];
                      bool _checked = task['done'];
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.all(10),
                          tileColor: Colors.black38,
                          selectedTileColor: Colors.black54,
                          activeColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: Text(task['task'],
                              style: Theme.of(context).textTheme.headline6),
                          value: _checked,
                          onChanged: isCaretaker
                              ? (bool value) {
                                  print('do u want to delete ');
                                  deleteTask(context, task['task']);
                                }
                              : (bool value) {
                                  print('initially checked is $_checked');
                                  setState(() {
                                    _checked = value;
                                    print(_checked.toString());
                                  });
                                  invertDone(task['task']);
                                },
                          secondary: const Icon(Icons.hourglass_empty,
                              color: Colors.white54),
                        );
                      });
                      // return ListTile(title: Text(course['task']));
                    }),
              );
            },
          ),
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
            child: bottomAppBar(
                id: widget.docid, currentDevice: widget.currentDevice)));
  }
}
