import 'package:flutter/material.dart';
import 'package:foodshelf/screens/tabs/cart_tab.dart';
import 'package:foodshelf/screens/tabs/home_tab.dart';
import 'package:foodshelf/screens/tabs/notifications_tab.dart';
import 'package:foodshelf/screens/tabs/profile_tab.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/rolling_nav_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int currentPage;
  Color currentColor = Colors.deepPurple;
  Color inactiveColor = Colors.black;
  PageController tabBarController;

  Image home, cart, notifications, profile;

  String url = 'assets/images/png/home.png';

  @override
  void initState() {
    super.initState();
    currentPage = 0;

    tabBarController = new PageController(initialPage: 0);

    home = Image.asset('assets/images/png/home_active.png', height: 20);

    // home = Image.asset('assets/images/png/home.png', height: 20);
    cart = Image.asset('assets/images/png/cart.png', height: 20);
    notifications =
        Image.asset('assets/images/png/notifications.png', height: 20);
    profile = Image.asset('assets/images/png/profile.png', height: 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: PageView(
          controller: tabBarController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomeTab(),
            CartTab(),
            NotificationsTab(),
            ProfileTab(),
          ]),
      bottomNavigationBar: Container(
          color: Colors.transparent,
          height: 95,
          child: RollingNavBar.iconData(
              navBarDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              onTap: (int index) {
                currentPage = index;
                tabBarController.jumpToPage(index);

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (index == 0) {
                    setState(() {
                      home = Image.asset('assets/images/png/home_active.png',
                          height: 20);
                      cart =
                          Image.asset('assets/images/png/cart.png', height: 20);
                      notifications = Image.asset(
                          'assets/images/png/notifications.png',
                          height: 20);
                      profile = Image.asset('assets/images/png/profile.png',
                          height: 20);
                    });
                  } else if (index == 1) {
                    setState(() {
                      home =
                          Image.asset('assets/images/png/home.png', height: 20);
                      cart = Image.asset('assets/images/png/cart_active.png',
                          height: 20);
                      notifications = Image.asset(
                          'assets/images/png/notifications.png',
                          height: 20);
                      profile = Image.asset('assets/images/png/profile.png',
                          height: 20);
                    });
                  } else if (index == 2) {
                    setState(() {
                      home =
                          Image.asset('assets/images/png/home.png', height: 20);
                      cart =
                          Image.asset('assets/images/png/cart.png', height: 20);
                      notifications = Image.asset(
                          'assets/images/png/notifications_active.png',
                          height: 20);
                      profile = Image.asset('assets/images/png/profile.png',
                          height: 20);
                    });
                  } else if (index == 3) {
                    setState(() {
                      home =
                          Image.asset('assets/images/png/home.png', height: 20);
                      cart =
                          Image.asset('assets/images/png/cart.png', height: 20);
                      notifications = Image.asset(
                          'assets/images/png/notifications.png',
                          height: 20);
                      profile = Image.asset(
                          'assets/images/png/profile_active.png',
                          height: 20);
                    });
                  }
                });
              },
              activeIndex: currentPage,
              indicatorColors: [
                Colors.transparent
              ],
              activeIconColors: [
                BrandColors.colorAccent
              ],

              // A list of length one implies the same color for all icons

              iconData: [
                home,
                cart,
                notifications,
                profile
              ],
              iconText: <Widget>[
                Column(children: [
                  SizedBox(height: 2),
                  Text('Home',
                      style: TextStyle(color: Colors.black, fontSize: 12))
                ]),
                Column(children: [
                  SizedBox(height: 2),
                  Text('Cart',
                      style: TextStyle(color: Colors.black, fontSize: 12))
                ]),
                Column(children: [
                  SizedBox(height: 2),
                  Text('Notifications',
                      style: TextStyle(color: Colors.black, fontSize: 12))
                ]),
                Column(children: [
                  SizedBox(height: 2),
                  Text('Profile',
                      style: TextStyle(color: Colors.black, fontSize: 12))
                ]),
              ])),
    );
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }
}
