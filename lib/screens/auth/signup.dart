import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUp';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends StateMVC<SignUpPage> {
  UserController _con = new UserController();

  _SignUpPageState() : super(UserController()) {
    _con = controller;
  }

  String countryValue;
  String stateValue;
  String cityValue;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hi, there',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 10),
                Text('Name',
                    style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                TextField(
                    cursorColor: BrandColors.colorAccent,
                    keyboardType: TextInputType.text,
                    enableSuggestions: true,
                    onChanged: (String input) => _con.user.name = input,
                    decoration: InputDecoration(
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        )),
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Phone Number',
                    style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                TextField(
                    cursorColor: BrandColors.colorAccent,
                    keyboardType: TextInputType.number,
                    enableSuggestions: true,
                    onChanged: (String input) => _con.user.phone = input,
                    decoration: InputDecoration(
                        hintText: '+971 55 92 55555',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        )),
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Email',
                    style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    cursorColor: BrandColors.colorAccent,
                    onChanged: (String input) => _con.user.email = input,
                    decoration: InputDecoration(
                        hintText: 'fariyad@gmail.com',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        )),
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Password',
                    style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                TextField(
                    cursorColor: BrandColors.colorAccent,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _con.hidePassword,
                    enableSuggestions: true,
                    onChanged: (String input) => _con.user.password = input,
                    decoration: InputDecoration(
                        hintText: '**********',
                        suffixIcon: InkWell(
                          onTap: () => _con.togglePasswordVisibility(),
                          child: Icon(_con.hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        )),
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Confirm Password',
                    style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                TextField(
                    cursorColor: BrandColors.colorAccent,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _con.hidePassword,
                    enableSuggestions: true,
                    onChanged: (String input) =>
                        _con.user.passwordConfirmation = input,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            _con.togglePasswordVisibility();
                          },
                          child: Icon(_con.hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: '**********',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        )),
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                SelectState(
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                    _con.user.country = value;
                    print(countryValue);
                  },
                  onStateChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                    _con.user.city = value;
                    print(cityValue);
                  },
                ),
                SizedBox(height: 20),
                ButtonWidget(
                    color: BrandColors.colorAccent,
                    onPressed: () {
                      if ((_con.user.name?.length ?? 0) < 3) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Name is too short');
                        return;
                      }
                      if ((_con.user.phone?.length ?? 0) < 10) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Please enter a valid phone number');
                        return;
                      }
                      if (!_con.user.email.contains('@')) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Please enter a valid email address');
                        return;
                      }
                      if (_con.user.password.length < 8) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Password is too short');
                        return;
                      }
                      if (_con.user.passwordConfirmation !=
                          _con.user.password) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Passwords do not match');
                        return;
                      }
                      if (_con.user.country == null) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Please select your country');
                        return;
                      }
                      if (_con.user.city == null) {
                        Utility.showMessage(_con.scaffoldKey?.currentContext,
                            message: 'Please select your city');
                        return;
                      }
                      _con.register();
                    },
                    title: 'Sign Up'),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Have an account? ',
                      style: TextStyle(fontFamily: 'Regular', fontSize: 16)),
                  Text(' Sign In',
                      style: TextStyle(fontFamily: 'Bold', fontSize: 16)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
