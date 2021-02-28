import 'package:flutter/material.dart';

class ProfieTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfieTile({
    this.icon,
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: Colors.black, size: 16),
      SizedBox(width: 10),
      Text(title, style: TextStyle(fontSize: 17)),
      Spacer(),
      Icon(Icons.chevron_right)
    ]);
  }
}
