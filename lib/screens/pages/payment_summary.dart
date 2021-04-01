import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/general_details_ctrl.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/screens/pages/checkout.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/counter_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class PaymentSummary extends StatefulWidget {
  static const routeName = '/PaymentSummary';

  final String url, title, desc, qty, subtotal;

  PaymentSummary({this.url, this.title, this.desc, this.qty, this.subtotal});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends StateMVC<PaymentSummary> {
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

  String serviceCharge, dlvryCharge;

  GeneralDetailsCtrl _ctrl;

  _PaymentSummaryState() : super(GeneralDetailsCtrl()) {
    _ctrl = controller;
  }

  GeneralDetails _data;

  void _getData() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getGeneralDetails(),
    ]);
    final IResponse<GeneralDetails> profileResponse = res.first;
    _data = profileResponse.data;

    setState(() {});
    serviceCharge = _data.serviceCharges;
    dlvryCharge = _data.deliveryCharges;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    numController.text = widget.qty;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonWidget(
                      color: BrandColors.colorAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                      },
                      title: 'Add Item'),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ButtonWidget(
                      color: BrandColors.colorAccent,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                    dlvryCharges: dlvryCharge,
                                    serviceCharges: serviceCharge,
                                    qty: widget.qty,
                                    subtotal: widget.subtotal)));
                      },
                      title: 'Checkout'),
                ),
              ],
            ),
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
                      Text('Payment Summary',
                          style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                      SizedBox(height: 30),
                      Row(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(widget.url, height: 80)),
                        SizedBox(width: 5),
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(widget.title,
                                  style: TextStyle(
                                      fontFamily: 'Bold', fontSize: 15)),
                              Text(widget.desc,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      color: Colors.grey,
                                      fontSize: 12)),
                            ])),
                      ]),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Quantity', style: TextStyle(fontSize: 16)),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CounterButton(
                                      iconData: Icons.remove,
                                      onTap: () {},
                                      color: Colors.red),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 1, right: 1, top: 4),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      color: Colors.transparent,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.transparent,
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        focusNode: focusKeyboard,
                                        controller: numController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Helvetica',
                                            color: Colors.black),
                                        keyboardType: TextInputType.number,
                                        onFieldSubmitted: (value) {},
                                      ),
                                    ),
                                  ),
                                  CounterButton(
                                    iconData: Icons.add,
                                    onTap: () {},
                                    color: Colors.grey,
                                  )
                                ]),
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
                            Text('$serviceCharge AED',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Medium')),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery charges',
                                style: TextStyle(fontSize: 16)),
                            Text('$dlvryCharge AED',
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
                                '${double.parse(widget.subtotal) + double.parse(serviceCharge) + double.parse(dlvryCharge)} AED',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontFamily: 'Medium'))
                          ]),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextField(
                            keyboardType: TextInputType.text,
                            enableSuggestions: true,
                            cursorColor: BrandColors.colorAccent,
                            maxLines: null,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: 'Special request',
                                contentPadding: EdgeInsets.all(20),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
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
