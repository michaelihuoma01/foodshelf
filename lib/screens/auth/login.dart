import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/screens/auth/forgot_password.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/screens/auth/signup.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../main_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/Login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  UserController _con = new UserController();

  _LoginPageState() : super(UserController()) {
    _con = controller;
  }

  FlutterSecureStorage storage = FlutterSecureStorage();
  String userToken;

  getToken() async {
    final overlay = Utility.load(context);
    userToken = await storage.read(key: 'token');
    overlay.remove();
    print(userToken);

    if (userToken != null) {
      Navigator.of(_con.scaffoldKey?.currentContext).pushReplacementNamed(
        MainPage.routeName,
        arguments: 0,
      );
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, getToken);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome!',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 30),
              Text('Phone Number',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  cursorColor: BrandColors.colorAccent,
                  keyboardType: TextInputType.number,
                  enableSuggestions: true,
                  onChanged: (String input) => _con.user.phone = input,
                  decoration: InputDecoration(
                      hintText: '+971 55 92 55555',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('Password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  cursorColor: BrandColors.colorAccent,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _con.hidePassword,
                  enableSuggestions: true,
                  onChanged: (String input) => _con.user.password = input,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () => _con.togglePasswordVisibility(),
                        child: Icon(_con.hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: '**********',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text('Forgot Password?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Medium',
                          color: BrandColors.colorAccent))),
              SizedBox(height: 20),
              ButtonWidget(
                  color: BrandColors.colorAccent,
                  onPressed: () {
                    if ((_con.user.phone?.length ?? 0) < 10) {
                      Utility.showMessage(_con.scaffoldKey?.currentContext,
                          message: 'Please enter a valid phone number');
                      return;
                    }

                    if ((_con.user.password?.length ?? 0) < 8) {
                      Utility.showMessage(_con.scaffoldKey?.currentContext,
                          message: 'Password is too short');
                      return;
                    }

                    _con.login();
                  },
                  title: 'Sign In'),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('New here? ',
                    style: TextStyle(fontFamily: 'Regular', fontSize: 16)),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(' Sign Up',
                      style: TextStyle(fontFamily: 'Bold', fontSize: 16)),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
