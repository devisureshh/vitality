import 'package:flutter/material.dart';
import 'package:vitality/components/bottomAppBar.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ChatBot extends StatefulWidget {
  final BluetoothDevice currentDevice;
  final String docid;
  final bool isCaretaker;

  ChatBot({this.docid, this.isCaretaker, this.currentDevice});
  @override
  _ChatBotState createState() => _ChatBotState();
  static const String id = 'chat_screen';
}

class _ChatBotState extends State<ChatBot> {
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
              'RUTH',
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
              id: widget.docid, currentDevice: widget.currentDevice),
        ));
  }
}
