import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/user_controller.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/user.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends StateMVC<EditProfile> {
  UserController _ctrl;

  _EditProfileState() : super(UserController()) {
    _ctrl = controller;
  }

  String countryValue, stateValue, cityValue;
  FlutterSecureStorage storage = FlutterSecureStorage();
  User _user;
  final _fnameField = TextEditingController();
  final _lnameField = TextEditingController();
  final _phoneField = TextEditingController();
  final _emailField = TextEditingController();
  String country, city;

  void _getUserProfile() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getUserProfile(),
    ]);
    print('?????<<<<<>>>>>???????${res.first}');
    final IResponse<User> profileResponse = res.first;
    _user = profileResponse.data;
    setState(() {});

    _fnameField.text = _user?.fname;
    _lnameField.text = _user?.lname;
    _phoneField.text = _user?.phone;
    _emailField.text = _user?.email;
    country = _user?.country;
    city = _user?.city;
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
    return  
           Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: Image.asset('assets/images/png/background.png').image,
              ),
            ),
            child: (_user == null)
                ? Center(child: CircularProgressIndicator())
                : Scaffold(
                    appBar: AppBarWidget(),
                    backgroundColor: Colors.transparent,
                    body: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 80),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Edit Profile',
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Bold')),
                              SizedBox(height: 30),
                              Text('Edit Name',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextFormField(
                                  controller: _fnameField,
                                  cursorColor: BrandColors.colorAccent,
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      hintText: 'Fariya D',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 20),
                              Text('Change phone number',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextField(
                                  controller: _phoneField,
                                  cursorColor: BrandColors.colorAccent,
                                  keyboardType: TextInputType.number,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      hintText: '+971 55 92 55555',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 20),
                              Text('Change email',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextField(
                                  controller: _emailField,
                                  keyboardType: TextInputType.emailAddress,
                                  enableSuggestions: true,
                                  cursorColor: BrandColors.colorAccent,
                                  decoration: InputDecoration(
                                      hintText: 'fariyad@gmail.com',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Country',
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Medium')),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 130),
                                    child: Text('City',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Medium')),
                                  ),
                                ],
                              ),
                              SelectState(
                                onCountryChanged: (value) {
                                  setState(() {
                                    countryValue = value;
                                  });
                                },
                                onStateChanged: (value) {
                                  setState(() {
                                    stateValue = value;
                                  });
                                },
                                onCityChanged: (value) {
                                  setState(() {
                                    cityValue = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    bottomSheet: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: ButtonWidget(
                            color: BrandColors.colorAccent,
                            onPressed: () async {
                              print(_ctrl.getDetails.value);
                            },
                            title: 'Save'),
                      ),
                    ),
                  ),
          );
        
  }
}
