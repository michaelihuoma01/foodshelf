import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/myorders_tile.dart';
import 'package:foodshelf/widgets/notifications_tile.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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
        appBar: AppBarWidget(),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Orders',
                      style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                  Text('Clear history',
                      style: TextStyle(
                          color: BrandColors.colorAccent,
                          fontFamily: 'Regular')),
                ],
              ),
              SizedBox(height: 20),
              MyOrdersTile(
                title: 'Brown rice (Long Grain)',
                subtitle:
                    'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print',
                price: 'Price: 50 AED',
                time: 'Today, 8:00 pm',
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
