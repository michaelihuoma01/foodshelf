import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/cart_controller.dart';
import 'package:foodshelf/controllers/hometab_controller.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/user.dart';
import 'package:foodshelf/screens/tabs/cart_tab.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/counter_button.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  static const routeName = '/Details';

  final String id;

  DetailsPage({Key key, this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends StateMVC<DetailsPage> {
  HomeTabController _ctrl;
  Category prodCat;
  _DetailsPageState() : super(HomeTabController()) {
    _ctrl = controller;
  }

  TextEditingController numController = new TextEditingController();
  int count = 1;
  String uuid, deviceID;
  var focusKeyboard = FocusNode();
  bool keyboardVisible = true;
  FlutterSecureStorage storage = FlutterSecureStorage();

  void setFocus() {
    if (!keyboardVisible) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(focusKeyboard);
    }
  }

  void _getProdDetails() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getProductDetails(widget.id),
    ]);
    final IResponse<Category> productResponse = res.first;
    prodCat = productResponse.data;
    setState(() {});
  }

  getID() async {
    deviceID = await storage.read(key: 'deviceID');
    print(deviceID);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getID();

    _getProdDetails();
    numController.text = count.toString();
    getID();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) =>
                _ctrl = context.watch<HomeTabController>(),
          ),
        ],
        builder: (context, child) {
          _ctrl.getProdList.addListener(
            () => Future.delayed(
              Duration(seconds: 1),
              () => setState(
                () {
                  _ctrl.fetchingAddresses = false;
                },
              ),
            ),
          );

          return Scaffold(
            backgroundColor: Colors.white,
            key: _ctrl.scaffoldKey,
            appBar: AppBarWidget(isColored: false),
            bottomNavigationBar: Container(
                height: 100,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Column(children: [
                        Text('Quantity',
                            style: TextStyle(
                                fontFamily: 'Bold', color: Colors.red)),
                        SizedBox(height: 3),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CounterButton(
                                  iconData: Icons.remove,
                                  onTap: () {
                                    setState(() {
                                      count--;
                                      numController.text = count.toString();
                                    });
                                    print(count);
                                  },
                                  color: Colors.red),
                              Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                      width: 30,
                                      height: 20,
                                      color: Colors.transparent,
                                      child: TextFormField(
                                        enabled: false,
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
                                      ))),
                              CounterButton(
                                  iconData: Icons.add,
                                  onTap: () {
                                    setState(() {
                                      count++;
                                      numController.text = count.toString();
                                    });
                                    print(count);
                                  },
                                  color: Colors.red)
                            ])
                      ]),
                      SizedBox(width: 20),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ButtonWidget(
                            color: BrandColors.colorAccent,
                            onPressed: () async {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => CartTab()));

                              // _ctrl.addToCart(
                              //   int.parse(uuid),
                              //   deviceID,
                              //   prodCat.id,
                              //   count,
                              //   double.parse(prodCat.price) * count,
                              // );
                            },
                            title: 'Add To Cart'),
                      ))
                    ]))),
            body: (_ctrl.fetchingAddresses || prodCat == null)
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(prodCat.image, width: double.infinity),
                          Row(children: [
                            Text(prodCat.title,
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
                            Text('Quantity: ${prodCat.qty}kg',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Medium')),
                            SizedBox(width: 30),
                            Text('Price: ${prodCat.price} AED',
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
                          Text(prodCat.description),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15))
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
          );
        });
  }
}
