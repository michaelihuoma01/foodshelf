import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/add_to_cart_item.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class CartTab extends StatefulWidget {
  static const routeName = '/CartTab';

  @override
  _CartTabState createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
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
          image: Image.asset('assets/images/png/background.png').image,
        ),
      ),
      child: Scaffold(
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
                  Text('Empty Cart',
                      style: TextStyle(
                          color: BrandColors.colorAccent,
                          fontFamily: 'Regular')),
                ],
              ),
              SizedBox(height: 20),
              AddToCartItem(
                title: 'Brown Rice (Long Grain)',
                author:
                    'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have ',
                price: '49.99',
                context: context,
                focusKeyboard: focusKeyboard,
                keyboardVisible: true,
                numController: numController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
