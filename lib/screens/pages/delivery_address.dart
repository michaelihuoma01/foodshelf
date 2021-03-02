import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';

class DeliveryAddress extends StatefulWidget {
  static const routeName = '/DeliveryAddress';

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
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
                  Text('Delivery Address',
                      style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                  SizedBox(height: 30),
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
                  Text('Area',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                          hintText: 'JLT',
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Building/Tower',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      cursorColor: BrandColors.colorAccent,
                      keyboardType: TextInputType.number,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                          hintText: 'Blu Bay Tower',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Floor No.',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      cursorColor: BrandColors.colorAccent,
                      decoration: InputDecoration(
                          hintText: '11',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Apartment No.',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      cursorColor: BrandColors.colorAccent,
                      decoration: InputDecoration(
                          hintText: '1102',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          )),
                      style: TextStyle(fontSize: 16)),
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
