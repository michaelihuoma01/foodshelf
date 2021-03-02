import 'package:flutter/material.dart';
import 'package:foodshelf/screens/tabs/cart_tab.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/counter_button.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = '/Details';

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
        color: Colors.grey[200],
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: Image.asset('assets/images/png/ricebag.png').image,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(isColored: false),
        bottomNavigationBar: Container(
            height: 100,
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  Column(children: [
                    Text('Quantity',
                        style:
                            TextStyle(fontFamily: 'Bold', color: Colors.red)),
                    SizedBox(height: 3),
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
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none),
                                        border: UnderlineInputBorder(
                                            borderSide: BorderSide.none)),
                                    focusNode: focusKeyboard,
                                    controller: numController,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Helvetica',
                                        color: Colors.red),
                                    keyboardType: TextInputType.number,
                                    onFieldSubmitted: (value) {},
                                  ))),
                          CounterButton(
                              iconData: Icons.add,
                              onTap: () {},
                              color: Colors.red)
                        ])
                  ]),
                  SizedBox(width: 20),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ButtonWidget(
                        color: BrandColors.colorAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartTab()));
                        },
                        title: 'Add To Cart'),
                  ))
                ]))),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Text('Brown Rice (Long Grain)',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Bold')),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ]),
                  SizedBox(height: 5),
                  Row(children: [
                    Text('Quantity: 1kg',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Medium')),
                    SizedBox(width: 30),
                    Text('Price: 59 AED',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Medium')),
                  ]),
                  SizedBox(height: 15),
                  Text('Product Description',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Medium')),
                  Text(
                      'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have'),
                  SizedBox(height: 10),
                  Text('Advantages:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Medium')),
                  Text(
                      'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs'),
                  SizedBox(height: 10),
                  Text('Reviews',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Medium')),
                  SizedBox(height: 5),
                  Row(children: [
                    Icon(Icons.star, color: Colors.orange, size: 17),
                    SizedBox(width: 5),
                    Text('4.5/5',
                        style: TextStyle(color: Colors.black, fontSize: 15))
                  ]),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 5),
                      Expanded(
                                              child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Anonymous',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Medium')),
                            Text(
                                'Lorem ipsum, or lipsum as it is sometimes known',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Medium')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
