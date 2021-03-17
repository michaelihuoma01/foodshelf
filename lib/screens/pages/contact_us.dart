import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/user.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ContactUs extends StatefulWidget {
  static const routeName = '/ContactUs';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends StateMVC<ContactUs> {
  UserController _ctrl;

  _ContactUsState() : super(UserController()) {
    _ctrl = controller;
  }

  User _user;
  final _messageField = TextEditingController();

  void _getUserProfile() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getUserProfile(),
    ]);
    print('?????<<<<<>>>>>???????${res.first}');
    final IResponse<User> profileResponse = res.first;
    _user = profileResponse.data;
    setState(() {});

    _ctrl.contact.fname = _user?.fname;
    _ctrl.contact.lname = _user?.lname;
    _ctrl.contact.email = _user?.email;
    setState(() {});

    print(_user?.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserProfile();
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
        appBar: AppBarWidget(),
        key: _ctrl.scaffoldKey,
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () {
                  _ctrl.contactUs();
                },
                title: 'Submit Request'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Us',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 5),
                Text('What do you want to talk about',
                    style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                SizedBox(height: 20),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                      controller: _messageField,
                      onChanged: (value) => _ctrl.contact.message = value,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      cursorColor: BrandColors.colorAccent,
                      maxLines: null,
                      decoration: InputDecoration(
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Ask us anything...',
                          contentPadding: EdgeInsets.all(20),
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 16.0)),
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
