import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/delivery_details.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DeliveryAddress extends StatefulWidget {
  static const routeName = '/DeliveryAddress';

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends StateMVC<DeliveryAddress> {
  DeliveryDetailsCtrl _ctrl;

  _DeliveryAddressState() : super(DeliveryDetailsCtrl()) {
    _ctrl = controller;
  }

  String countryValue, stateValue, cityValue;
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
                  SizedBox(height: 20),
                  SelectState(
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                        _ctrl.dlvry.country = value;
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
                        _ctrl.dlvry.city = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Area',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      onChanged: (value) => _ctrl.dlvry.area = value,
                      decoration: InputDecoration(
                          hintText: 'JLT',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Building/Tower',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      cursorColor: BrandColors.colorAccent,
                      keyboardType: TextInputType.number,
                      enableSuggestions: true,
                      onChanged: (value) => _ctrl.dlvry.building = value,
                      decoration: InputDecoration(
                          hintText: 'Blu Bay Tower',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Floor No.',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      enableSuggestions: true,
                      onChanged: (value) => _ctrl.dlvry.floor = value,
                      cursorColor: BrandColors.colorAccent,
                      decoration: InputDecoration(
                          hintText: '11',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Apartment No.',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      enableSuggestions: true,
                      cursorColor: BrandColors.colorAccent,
                      onChanged: (value) => _ctrl.dlvry.apartment = value,
                      decoration: InputDecoration(
                          hintText: '1102',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
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
                onPressed: () async {
                  _ctrl.dlvry.userID = await storage.read(key: 'uid');

                  _ctrl.dlvry.country = 'Nigeria';

                  print(_ctrl.dlvry.country);

                  _ctrl.dlvryDetails(
                      _ctrl.dlvry.area,
                      _ctrl.dlvry.building,
                      _ctrl.dlvry.apartment,
                      _ctrl.dlvry.country,
                      _ctrl.dlvry.city,
                      _ctrl.dlvry.userID,
                      _ctrl.dlvry.floor);
                },
                title: 'Save'),
          ),
        ),
      ),
    );
  }
}
