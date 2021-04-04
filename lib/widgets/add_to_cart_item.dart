import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/counter_button.dart';

class AddToCartItem extends StatelessWidget {
  final String title, author, price, qty, url;
  final BuildContext context;
  final String count;
  final Function onTap, onPressed, plus, minus;
  final focusKeyboard;

  final bool keyboardVisible;

  AddToCartItem(
      {this.author,
      this.onTap,
      this.onPressed,
      this.title,
      this.context,
      this.plus,
      this.minus,
      this.qty,
      this.price,
      this.url,
      this.count,
      this.focusKeyboard,
      this.keyboardVisible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
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
                      child: Image.network(url, height: 100)),
                  SizedBox(height: 5),
                  Text('Quantity', style: TextStyle(fontFamily: 'Bold')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CounterButton(
                          iconData: Icons.remove,
                          onTap: minus,
                          color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(count),
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(left: 10, right: 1, top: 4),
                      //   child: Container(
                      //     width: 20,
                      //     height: 20,
                      //     color: Colors.transparent,
                      //     child: TextFormField(
                      //       decoration: InputDecoration(
                      //         fillColor: Colors.transparent,
                      //         enabledBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide.none),
                      //         focusedBorder: UnderlineInputBorder(
                      //             borderSide: BorderSide.none),
                      //         border: UnderlineInputBorder(
                      //             borderSide: BorderSide.none),
                      //         labelText: qty,
                      //       ),
                      //       focusNode: focusKeyboard,
                      //       controller: numController,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(fontFamily: 'Helvetica'),
                      //       keyboardType: TextInputType.number,
                      //       onFieldSubmitted: (value) {},
                      //     ),
                      //   ),
                      // ),
                      CounterButton(
                        iconData: Icons.add,
                        onTap: plus,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(onTap: onTap, child: Icon(Icons.cancel)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(title,
                          style: TextStyle(fontFamily: 'Bold', fontSize: 15)),
                    ),
                    Container(
                      child: Text(author,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Regular',
                              color: Colors.grey,
                              fontSize: 12)),
                    ),
                    TextButton(
                        onPressed: onPressed,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(100),
                              color: BrandColors.colorAccent,
                            ),
                            height: 40,
                            child: Center(
                                child: Text('Place Order',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Bold'))))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
