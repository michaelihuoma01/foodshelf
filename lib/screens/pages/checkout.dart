import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/delivery_details.dart';
import 'package:foodshelf/models/delivery.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/screens/pages/delivery_address.dart';
import 'package:foodshelf/screens/pages/payment.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/Checkout';
  final String subtotal, serviceCharges, dlvryCharges;

  CheckoutScreen({this.subtotal, this.dlvryCharges, this.serviceCharges, qty});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends StateMVC<CheckoutScreen> {
  DeliveryDetailsCtrl _ctrl;

  _CheckoutScreenState() : super(DeliveryDetailsCtrl()) {
    _ctrl = controller;
  }

  Delivery dlvry;
  TextEditingController numController = new TextEditingController();
  var focusKeyboard = FocusNode();

  bool keyboardVisible = true;
  void setFocus() {
    if (!keyboardVisible) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(focusKeyboard);
    }
  }

  void _getDeliveryAddress() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getDlvryAddress(),
    ]);
    final IResponse<Delivery> profileResponse = res.first;
    dlvry = profileResponse.data;
    setState(() {});
    setState(() {});
    print('////////////------//////${dlvry.area}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController.text = '1';
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
        key: _ctrl.scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(),
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()));
                },
                title: 'Proceed to payment'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: (_ctrl.fetchingAddresses)
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Checkout',
                          style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                      SizedBox(height: 30),
                      Center(child: Text('Map view here')),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: new BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: Colors.grey),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dlvry.area,
                                        style: TextStyle(
                                            fontSize: 16, fontFamily: 'Bold')),
                                    Text(
                                        '${dlvry.building}, ${dlvry.floor}, ${dlvry.apartment}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Regular')),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DeliveryAddress()));
                                },
                                child: Text('Change',
                                    style: TextStyle(
                                        color: BrandColors.colorAccent,
                                        fontFamily: 'Bold')),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Quantity', style: TextStyle(fontSize: 16)),
                            Text('5',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Medium')),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sub total', style: TextStyle(fontSize: 16)),
                            Text('${widget.subtotal} AED',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Medium')),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Service charges',
                                style: TextStyle(fontSize: 16)),
                            Text('${widget.serviceCharges} AED',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Medium')),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery charges',
                                style: TextStyle(fontSize: 16)),
                            Text('${widget.dlvryCharges} AED',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Medium')),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text(
                                '${double.parse(widget.subtotal) + double.parse(widget.serviceCharges) + double.parse(widget.dlvryCharges)} AED',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: 'Medium')),
                          ]),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
