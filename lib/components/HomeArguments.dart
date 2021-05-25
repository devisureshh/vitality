import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomeArgs {
  final String docid;
  final bool isCaretaker;
  final BluetoothDevice currentDevice;

  HomeArgs({this.docid, this.isCaretaker, this.currentDevice});
}
