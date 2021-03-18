import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/hometab_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/add_to_cart_item.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class CartTab extends StatefulWidget {
  static const routeName = '/CartTab';

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends StateMVC<CartTab> {
  HomeTabController _ctrl;

  _CartTabState() : super(HomeTabController()) {
    _ctrl = controller;
  }

  TextEditingController numController = new TextEditingController();
  var focusKeyboard = FocusNode();
  String deviceID;
  bool keyboardVisible = true;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  Category cart;
  void setFocus() {
    if (!keyboardVisible) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(focusKeyboard);
    }
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
  }

  @override
  Widget build(BuildContext context) {
    var cartList = <Widget>[];
    if (_ctrl?.getCartList?.value != null) {
      numController.text = _ctrl.cartList.qty;
      cartList = _ctrl.getCartList.value
          .map(
            (cart) => GestureDetector(
              onTap: () { 
              },
              child: AddToCartItem(
                title: cart.title,
                author: cart.description,
                price: cart.price,
                context: context,
                qty: cart.qty,
                focusKeyboard: focusKeyboard,
                keyboardVisible: true,
                numController: numController,
                onTap: () => _ctrl.deleteCartItem(deviceID, cart.productID),
                // onPressed: () => _ctrl.updateCartItem(),
              ),
            ),
          )
          .toList();
    }

    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) =>
                _ctrl = context.watch<HomeTabController>(),
          ),
        ],
        builder: (context, child) {
          _ctrl.getCartList.addListener(
            () => Future.delayed(
              Duration(seconds: 1),
              () => setState(
                () {
                  _ctrl.fetchingAddresses = false;
                },
              ),
            ),
          );
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: Image.asset('assets/images/png/background.png').image,
              ),
            ),
            child: (_ctrl.fetchingAddresses)
                ? Center(child: CircularProgressIndicator())
                : Scaffold(
                    key: _ctrl.scaffoldKey,
                    backgroundColor: Colors.transparent,
                    body: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 200),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('My Cart',
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Bold')),
                              InkWell(
                                onTap: () {
                                  _ctrl.emptyCart(deviceID);
                                },
                                child: Text('Empty Cart',
                                    style: TextStyle(
                                        color: BrandColors.colorAccent,
                                        fontFamily: 'Regular')),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              child: (_ctrl.getCartList.value.length != 0)
                                  ? ListView(
                                      scrollDirection: Axis.vertical,
                                      children: cartList)
                                  : Center(child: Text('Cart is empty')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
