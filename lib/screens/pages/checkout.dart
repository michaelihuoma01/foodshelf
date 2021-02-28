import 'package:flutter/material.dart';
import 'package:foodshelf/screens/pages/payment.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/counter_button.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
            child: Column(
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
                        Icon(Icons.location_on_outlined, color: Colors.grey),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Home, JLT Beach',
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Bold')),
                            Text('Al Rustamani building, 5th floor, \nApt 510',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Regular')),
                          ],
                        ),
                        Spacer(),
                        Text('Change',
                            style: TextStyle(
                                color: BrandColors.colorAccent,
                                fontFamily: 'Bold'))
                      ],
                    ),
                  ),
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
