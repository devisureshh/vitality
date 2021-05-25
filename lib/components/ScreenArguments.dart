import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ScreenArguments {
  final String docid;
  final bool isCaretaker;
final BluetoothDevice currentDevice;
  ScreenArguments({this.docid, this.isCaretaker,this.currentDevice});
}
