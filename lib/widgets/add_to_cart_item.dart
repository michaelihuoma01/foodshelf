import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/counter_button.dart';

class AddToCartItem extends StatelessWidget {
  final String title, author, price;
  final BuildContext context;
  final TextEditingController numController;
  final focusKeyboard;

  final bool keyboardVisible;

  AddToCartItem(
      {this.author,
      this.title,
      this.context,
      this.price,
      this.numController,
      this.focusKeyboard,
      this.keyboardVisible});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/png/ricebag.png',
                        height: 100)),
                SizedBox(height: 5),
                Text('Quantity', style: TextStyle(fontFamily: 'Bold')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CounterButton(
                        iconData: Icons.remove,
                        onTap: () {},
                        color: Colors.red),
                    Padding(
                      padding: const EdgeInsets.only(left: 1, right: 1, top: 4),
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
                          style: TextStyle(fontFamily: 'Helvetica'),
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {},
                        ),
                      ),
                    ),
                    CounterButton(
                      iconData: Icons.add,
                      onTap: () {},
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(title,
                      style: TextStyle(fontFamily: 'Bold', fontSize: 15)),
                  Container(
                    child: Text(author,
                        style: TextStyle(
                            fontFamily: 'Regular',
                            color: Colors.grey,
                            fontSize: 12)),
                  ),
                  FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100)),
                      color: BrandColors.colorAccent,
                      textColor: Colors.black,
                      onPressed: () {},
                      child: Container(
                          height: 40,
                          child: Center(
                              child: Text('Place Order',
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Bold'))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
