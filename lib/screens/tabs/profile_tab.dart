import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/screens/pages/about_us.dart';
import 'package:foodshelf/screens/pages/change_language.dart';
import 'package:foodshelf/screens/pages/change_password.dart';
import 'package:foodshelf/screens/pages/contact_us.dart';
import 'package:foodshelf/screens/pages/delivery_address.dart';
import 'package:foodshelf/screens/pages/edit_profile.dart';
import 'package:foodshelf/screens/pages/faqs.dart';
import 'package:foodshelf/screens/pages/my_orders.dart';
import 'package:foodshelf/screens/pages/t_and_c.dart';
import 'package:foodshelf/widgets/profile_tile.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileTab extends StatefulWidget {
  static const routeName = '/ProfileTab';

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends StateMVC<ProfileTab> {
  UserController _con = new UserController();

  _ProfileTabState() : super(UserController()) {
    _con = controller;
  }

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
        key: _con.scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profile Settings',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    child: ProfieTile(icon: Icons.edit, title: 'Edit Profile')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyOrders()));
                    },
                    child: ProfieTile(icon: Icons.list, title: 'My Orders')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                    child:
                        ProfieTile(icon: Icons.lock, title: 'Change Password')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeliveryAddress()));
                    },
                    child: ProfieTile(
                        icon: Icons.location_on, title: 'Delivery Address')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeLanguage()));
                    },
                    child:
                        ProfieTile(icon: Icons.web, title: 'Change Language')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ContactUs()));
                    },
                    child: ProfieTile(icon: Icons.call, title: 'Contact Us')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Faqs()));
                    },
                    child: ProfieTile(icon: Icons.help, title: 'FAQs')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TandC()));
                    },
                    child: ProfieTile(
                        icon: Icons.list_alt, title: 'Terms & Conditions')),
                SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                    child: ProfieTile(icon: Icons.info, title: 'About Us')),
                SizedBox(height: 30),
                InkWell(
                  onTap: () => Utility.logout(context),
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new,
                          color: Colors.black, size: 16),
                      SizedBox(width: 10),
                      Text('Log out', style: TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
