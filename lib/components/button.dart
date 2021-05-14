import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.text, this.onPressed});
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent, // background
      ), // foreground
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 25.0, fontFamily: 'Montserrat', color: Colors.white),
      ),
    );
  }
}
