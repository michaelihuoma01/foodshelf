import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/screens/auth/new_password.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class VerificationPage extends StatefulWidget {
  static const routeName = '/Verification';

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends StateMVC<VerificationPage> {
  UserController _con = new UserController();

  _VerificationPageState() : super(UserController()) {
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
        appBar: AppBarWidget(),
        key: _con.scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Code',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 10),
              Text('You may have a code in your email, enter it here',
                  style: TextStyle(fontSize: 16, fontFamily: 'Regular')),
              SizedBox(height: 30),
              Text('Verification code',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  cursorColor: BrandColors.colorAccent,
                  onChanged: (String input) => _con.token = input,
                  decoration: InputDecoration(
                      hintText: 'o o o o',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 26,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 30),
              ButtonWidget(
                  color: BrandColors.colorAccent,
                  onPressed: () {
                    print(_con.token);
                    _con.verify(_con.token);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NewPasswordPage()));
                  },
                  title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
