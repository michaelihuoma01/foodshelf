import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/ChangePassword';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends StateMVC<ChangePassword> {
  UserController _ctrl;
  _ChangePasswordState() : super(UserController()) {
    _ctrl = controller;
  }

  String oldPass, newPass, confirmPass, uid;
  FlutterSecureStorage storage = FlutterSecureStorage();

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
        key: _ctrl.scaffoldKey,
        backgroundColor: Colors.transparent,
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () async {
                  uid = await storage.read(key: 'uid');

                  _ctrl.changePass(oldPass, newPass, confirmPass, uid);
                },
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
                  onChanged: (value) => oldPass = value,
                  decoration: InputDecoration(
                      hintText: '*********',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
                  onChanged: (value) => newPass = value,
                  decoration: InputDecoration(
                      hintText: '**********',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
                  onChanged: (value) => confirmPass = value,
                  decoration: InputDecoration(
                      hintText: '***********',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
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
