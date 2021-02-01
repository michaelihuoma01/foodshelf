import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final Color color;

  const CounterButton({Key key, this.iconData, this.onTap, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 17,
        width: 17,
        child: Icon(iconData, size: 10, color: color),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5,
            color: color,
          ),
        ),
      ),
    );
  }
}
