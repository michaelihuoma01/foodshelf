import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/add_to_cart_item.dart';
import 'package:foodshelf/widgets/notifications_tile.dart';

class NotificationsTab extends StatefulWidget {
  static const routeName = '/NotificationsTab';

  @override
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: Image.asset('assets/images/png/background.png').image,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Notifications',
                      style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                  Text('Clear notifications',
                      style: TextStyle(
                          color: BrandColors.colorAccent,
                          fontFamily: 'Regular')),
                ],
              ),
              SizedBox(height: 20),
              NotificationsTile(
                title: 'Your order A1560 has been shipped',
                author:
                    'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have ',
                price: '49.99',
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
