import 'package:flutter/material.dart';

class biom extends StatefulWidget {
  biom({this.image, this.number});
  final int number;
  final String image;

  @override
  _biomState createState() => _biomState();
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
            Text(widget.number.toString(),
                style: Theme.of(context).textTheme.headline2),
          ],
        ),
      ),
    );
  }
}
