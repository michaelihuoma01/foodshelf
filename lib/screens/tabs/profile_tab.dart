import 'package:flutter/material.dart';
import 'package:foodshelf/widgets/profile_tile.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
          padding: const EdgeInsets.only(left: 30, right: 30, top: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Settings',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.edit, title: 'Edit Profile'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.list, title: 'My Orders'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.lock, title: 'Change Password'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.location_on, title: 'Delivery Address'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.web, title: 'Change Language'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.call, title: 'Contact Us'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.help, title: 'FAQs'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.list_alt, title: 'Terms & Conditions'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.info, title: 'About Us'),
              SizedBox(height: 20),
              ProfieTile(icon: Icons.power, title: 'Log Out'),
            ],
          ),
        ),
      ),
    );
  }
}
