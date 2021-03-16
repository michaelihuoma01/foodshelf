import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/screens/auth/new_password.dart';
import 'package:foodshelf/screens/auth/verification.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/FogotPassword';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends StateMVC<ForgotPassword> {
  UserController _con = new UserController();

  _ForgotPasswordState() : super(UserController()) {
    _con = controller;
  }
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
        backgroundColor: Colors.transparent,
        key: _con.scaffoldKey,
        appBar: AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Email',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 10),
              Text('Please provide us with your email, to verify your account',
                  style: TextStyle(fontSize: 16, fontFamily: 'Regular')),
              SizedBox(height: 30),
              Text('Email',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  cursorColor: BrandColors.colorAccent,
                  onChanged: (String input) {
                    _con.user.phone = input;
                  },
                  decoration: InputDecoration(
                      hintText: 'Please enter your email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              ButtonWidget(
                  color: BrandColors.colorAccent,
                  onPressed: () {
                    _con.forgotPass(_con.user.phone);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                    builder: (context) => NewPasswordPage()));
                  },
                  title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
