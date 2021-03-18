import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/delivery_details.dart';
import 'package:foodshelf/models/delivery.dart';
import 'package:foodshelf/models/iresponse.dart';
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

  Delivery dlvry;
  String countryValue, stateValue, cityValue;
  FlutterSecureStorage storage = FlutterSecureStorage();

  final _areaField = TextEditingController();
  final _buildingField = TextEditingController();
  final _floorField = TextEditingController();
  final _apartmentField = TextEditingController();

  void _getDeliveryAddress() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getDlvryAddress(),
    ]);
    final IResponse<Delivery> profileResponse = res.first;
    dlvry = profileResponse.data;
    setState(() {});

    _areaField.text = dlvry?.area;
    _buildingField.text = dlvry?.building;
    _floorField.text = dlvry?.floor;
    _apartmentField.text = dlvry?.apartment;
    setState(() {});
    print('////////////------//////${dlvry.area}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDeliveryAddress();
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
        appBar: AppBarWidget(),
        key: _ctrl.scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child:
             (_ctrl.fetchingAddresses)
                ? Center(child: CircularProgressIndicator())
                : 
                Container(
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
                              _ctrl.dlvry.city = value;
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
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Medium')),
                        TextFormField(
                            keyboardType: TextInputType.text,
                            enableSuggestions: true,
                            controller: _areaField,
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
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Medium')),
                        TextField(
                            cursorColor: BrandColors.colorAccent,
                            keyboardType: TextInputType.number,
                            enableSuggestions: true,
                            controller: _buildingField,
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
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Medium')),
                        TextField(
                            enableSuggestions: true,
                            controller: _floorField,
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
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Medium')),
                        TextField(
                            enableSuggestions: true,
                            cursorColor: BrandColors.colorAccent,
                            controller: _apartmentField,
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

                  print(_ctrl.dlvry.country);
                  print(_ctrl.dlvry.city);

                  _ctrl.dlvryDetails(
                    _ctrl.dlvry.area,
                    _ctrl.dlvry.building,
                    _ctrl.dlvry.country,
                    _ctrl.dlvry.city,
                    _ctrl.dlvry.userID,
                    _ctrl.dlvry.floor,
                    _ctrl.dlvry.apartment,
                  );
                },
                title: 'Save'),
          ),
        ),
      ),
    );
  }
}
