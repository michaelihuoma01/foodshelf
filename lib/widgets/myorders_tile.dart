import 'package:flutter/material.dart';

class MyOrdersTile extends StatelessWidget {
  final String title, subtitle, price, time;
  final BuildContext context;
  final TextEditingController numController;
  final focusKeyboard;

  final bool keyboardVisible;

  MyOrdersTile(
      {this.subtitle,
      this.title,
      this.context,
      this.price,
      this.time,
      this.numController,
      this.focusKeyboard,
      this.keyboardVisible});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/png/ricebag.png',
                        height: 100)),
                SizedBox(height: 5),
                FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100)),
                    color: Colors.black38,
                    textColor: Colors.black,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          height: 40,
                          child: Center(
                              child: Text('Pending',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))),
                    )),
              ],
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(title,
                      style: TextStyle(fontFamily: 'Medium', fontSize: 15)),
                  Text(price,
                      style: TextStyle(
                          fontFamily: 'Medium',
                          color: Colors.red,
                          fontSize: 14)),
                  SizedBox(height: 3),
                  Text(subtitle,
                      style: TextStyle(fontFamily: 'Regular', fontSize: 12)),
                  Text(time,
                      style: TextStyle(fontFamily: 'Medium', fontSize: 14)),
                  FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100)),
                      color: Colors.red,
                      textColor: Colors.black,
                      onPressed: () {},
                      child: Container(
                          height: 40,
                          child: Center(
                              child: Text('Cancel Order',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
