import 'package:flutter/material.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class NewPasswordPage extends StatefulWidget {
  static const routeName = '/NewPassword';

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New Password',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 10),
              Text('Create a password, which isn\'t easy to guess',
                  style: TextStyle(fontSize: 16, fontFamily: 'Regular')),
              SizedBox(height: 30),
              Text('New Password',
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
              Text('Confirm Password',
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
              ButtonWidget(
                  color: BrandColors.colorAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  title: 'Next'),
            ],
          ),
        ),
      ),
    );
  }
}
