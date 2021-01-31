import 'package:flutter/material.dart';
import 'package:foodshelf/screens/auth/forgot_password.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/screens/auth/signup.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  decoration: InputDecoration(
                      hintText: '+971 55 92 55555',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('Password',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
                  cursorColor: BrandColors.colorAccent,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                      hintText: '**********',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
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
