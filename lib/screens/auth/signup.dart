import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hi, there',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 10),
              Text('Name',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
              TextField(
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
              Text('Email',
                  style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
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
              Text('Confirm Password',
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
              // SelectFormField(
              //   type: SelectFormField.dropdown, // or can be dialog
              //   initialValue: 'circle',
              //   icon: Icon(Icons.format_shapes),
              //   labelText: 'Shape',
              //   items: _items,
              //   onChanged: (val) => print(val),
              //   onSaved: (val) => print(val),
              // ),
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
              ButtonWidget(
                  color: BrandColors.colorAccent,
                  onPressed: () {},
                  title: 'Sign In'),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('New here? ',
                    style: TextStyle(fontFamily: 'Regular', fontSize: 16)),
                Text(' Sign Up',
                    style: TextStyle(fontFamily: 'Bold', fontSize: 16)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
