import 'package:flutter/material.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/screens/pages/checkout.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/counter_button.dart';

class PaymentSummary extends StatefulWidget {
  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numController.text = '1';
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
                                builder: (context) => CheckoutScreen()));
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment Summary',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 30),
                Row(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/png/ricebag.png',
                          height: 100)),
                  SizedBox(width: 5),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Brown Rice (Long Grain)',
                            style: TextStyle(fontFamily: 'Bold', fontSize: 15)),
                        Text(
                            'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have ',
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Text('50 AED',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service charges', style: TextStyle(fontSize: 16)),
                      Text('03 AED',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery charges', style: TextStyle(fontSize: 16)),
                      Text('10 AED',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount',
                          style: TextStyle(fontSize: 20, color: Colors.red)),
                      Text('73 AED',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontFamily: 'Medium')),
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
                          enabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Special request',
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
