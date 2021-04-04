import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/controllers/hometab_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/screens/pages/payment_summary.dart';
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
              onTap: () {},
              child: AddToCartItem(
                title: cart.title,
                author: cart.description,
                price: cart.total,
                url: cart.image,
                context: context,
                qty: cart.qty,
                focusKeyboard: focusKeyboard,
                onPressed: () {
                  print(cart.total);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentSummary(
                              url: cart.image,
                              desc: cart.description,
                              qty: cart.qty,
                              title: cart.title,
                              subtotal: cart.total)));
                },
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
                    bottomSheet: Container(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ButtonWidget(
                            color: BrandColors.colorAccent,
                            onPressed: () {
                              print(_ctrl.cartList.image);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             PaymentSummary(url: cart.image)));
                            },
                            title: 'Checkout'),
                      ),
                    ),
                    body: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 170),
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
                          Expanded(
                            child: Container(
<<<<<<< HEAD
                              child: 
                              // (_ctrl.getCartList.value.length != 0)
                              //     ? 
                                  ListView(
=======
                              child: (_ctrl.getCartList.value?.length != 0)
                                  ? ListView(
>>>>>>> f59c6125bec517c46d04cd7332f884b5918d844e
                                      scrollDirection: Axis.vertical,
                                      children: cartList)
                                  // : Padding(
                                  //     padding: const EdgeInsets.only(top: 30),
                                  //     child: Text('Cart is Empty'),
                                  //   ),
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
