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
    numController.text = '1';
    getID();
  }

  @override
  Widget build(BuildContext context) {
    var cartList = <Widget>[];
    if (_ctrl?.getCartList?.value != null) {
      cartList = _ctrl.getCartList.value
          .map(
            (Category cart) => GestureDetector(
              onTap: () {},
              child: AddToCartItem(
                title: cart?.title ?? '',
                author:
                    'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have ',
                price: '49.99',
                context: context,
                focusKeyboard: focusKeyboard,
                keyboardVisible: true,
                numController: numController,
                onTap: () => _ctrl.deleteCartItem(deviceID, cart.id),
                // onPressed: () => _ctrl.updateCartItem(),
              ),
            ),
          )
          .toList();
    } else {
      Text('NOOOOO');
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
            child: Scaffold(
              key: _ctrl.scaffoldKey,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 200),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My Cart',
                            style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                        InkWell(
                          onTap: () => _ctrl.emptyCart(deviceID),
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
                        child: ListView(
                            scrollDirection: Axis.vertical, children: cartList),
                      ),
                    ),
                    // AddToCartItem(
                    //   title: 'Brown Rice (Long Grain)',
                    //   author:
                    //       'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have ',
                    //   price: '49.99',
                    //   context: context,
                    //   focusKeyboard: focusKeyboard,
                    //   keyboardVisible: true,
                    //   numController: numController,
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
