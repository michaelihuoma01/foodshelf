import 'package:flutter/material.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class OrderSummary extends StatefulWidget {
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
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
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                title: 'Done'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Summary',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 10),
                Text(
                    'Your order is submitted, you will get it delivered in 2 days (as committed time).',
                    style: TextStyle(fontFamily: 'Regular', fontSize: 16)),
                SizedBox(height: 5),
                Text('In the meantime keep enjoying our services',
                    style: TextStyle(fontFamily: 'Medium', fontSize: 16)),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order no.', style: TextStyle(fontSize: 16)),
                      Text('A5120',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order date', style: TextStyle(fontSize: 16)),
                      Text('23/12/2020',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order time', style: TextStyle(fontSize: 16)),
                      Text('8:55:12 pm',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Item name', style: TextStyle(fontSize: 16)),
                      Text('Brown rice',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity', style: TextStyle(fontSize: 16)),
                      Text('2',
                          style: TextStyle(fontSize: 16, fontFamily: 'Medium')),
                    ]),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price', style: TextStyle(fontSize: 16)),
                      Text('50 AED',
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
