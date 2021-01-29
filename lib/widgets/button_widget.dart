import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  ButtonWidget({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(100)),
      color: color,
      textColor: Colors.black,
      onPressed: onPressed,
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontFamily: 'Bold'),
          ),
        ),
      ),
    );
  }
}
