import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class Faqs extends StatefulWidget {
  static const routeName = '/FAQs';

  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(30),
          child: ButtonWidget(
              color: BrandColors.colorAccent,
              onPressed: () {},
              title: 'Submit'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FAQS',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 20),
                Text('● Can i add more than one item to my cart?',
                    style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
                SizedBox(height: 10),
                Text('● Where can i change the language of this app?',
                    style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
                SizedBox(height: 10),
                Text('● Can i change phone number?',
                    style: TextStyle(fontSize: 18, fontFamily: 'Medium')),
                SizedBox(height: 20),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
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
                          hintText: 'Look for anything...',
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
