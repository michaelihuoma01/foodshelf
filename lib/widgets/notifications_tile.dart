import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';

class NotificationsTile extends StatelessWidget {
  final String title, author, price;
  final BuildContext context;

  NotificationsTile({this.author, this.title, this.context, this.price});

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
                Container(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/png/ricebag.png',
                          height: 70)),
                ),
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(title,
                      style: TextStyle(fontFamily: 'Bold', fontSize: 15)),
                  SizedBox(height: 3),
                  Text('Click here to check the details',
                      style: TextStyle(
                          fontFamily: 'Regular',
                          decoration: TextDecoration.underline,
                          color: BrandColors.colorAccent,
                          fontSize: 12)),
                  SizedBox(height: 3),
                  Text(
                    '* Just Now',
                    style: TextStyle(
                        fontFamily: 'Bold', color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
