import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/EditProfile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String countryValue, stateValue, cityValue;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Edit Profile',
                      style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                  SizedBox(height: 30),
                  Text('Edit Name',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextFormField(
                      cursorColor: BrandColors.colorAccent,
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                          hintText: 'Fariya D',
                          hintStyle: TextStyle(
                            color: BrandColors.colorAccent,
                            fontSize: 16.0,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Change phone number',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
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
                  Text('Change email',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      cursorColor: BrandColors.colorAccent,
                      decoration: InputDecoration(
                          hintText: 'fariyad@gmail.com',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Country',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                      Padding(
                        padding: const EdgeInsets.only(right: 130),
                        child: Text('City',
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Medium')),
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
                onPressed: () {},
                title: 'Save'),
          ),
        ),
      ),
    );
  }
}
