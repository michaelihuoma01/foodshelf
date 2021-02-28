import 'package:flutter/material.dart';
import 'package:foodshelf/screens/pages/order_summary.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/country_state_city_picker.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
                  Text('Payment',
                      style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                  SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('First name',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      hintText: 'Type your first name',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Last name',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      hintText: 'Type your last name',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ]),
                  SizedBox(height: 20),
                  Text('Credit Card number',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                          hintText: '000 000 00000000',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )),
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Issue Date/Year',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      hintText: '08/19',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expiration Date/Year',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Medium')),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                      hintText: '08/24',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      )),
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ]),
                  SizedBox(height: 20),
                  Text('Enter CVV',
                      style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                  TextField(
                      cursorColor: BrandColors.colorAccent,
                      keyboardType: TextInputType.number,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                          hintText: 'Enter 3 digit code (back of your card)',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderSummary()));
                },
                title: 'Pay'),
          ),
        ),
      ),
    );
  }
}
