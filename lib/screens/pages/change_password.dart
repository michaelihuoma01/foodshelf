import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/ChangePassword';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: Image.asset('assets/images/png/background.png').image,
        ),
      ),
      child: Scaffold(
        appBar: AppBarWidget(),
        backgroundColor: Colors.transparent,
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () {},
                title: 'Save Changes'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Change Password',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 30),
              Text('Old password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  obscureText: true,
                  cursorColor: BrandColors.colorAccent,
                  decoration: InputDecoration(
                      hintText: '..........',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('New password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  obscureText: true,
                  cursorColor: BrandColors.colorAccent,
                  decoration: InputDecoration(
                      hintText: '..........',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('Confirm new password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  obscureText: true,
                  cursorColor: BrandColors.colorAccent,
                  decoration: InputDecoration(
                      hintText: '..........',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
