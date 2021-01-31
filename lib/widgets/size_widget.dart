import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackageSizeWidget extends StatelessWidget {
  final String label;
  final double cost;

  const PackageSizeWidget({
    Key key,
    this.label,
    this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: 15, top: 15),
      child: Container(
        // margin: EdgeInsets.only(right: 8),
        // width: width * .4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          // fit: BoxFit.fill,
                          image: Image.asset('assets/images/png/ricebag.png')
                              .image,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        label, // label,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Theme.of(context).accentColor,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 28,
              ),
              child: Text(
                'AED ${cost.toInt()}', // label,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors
                          .white, //Theme.of(context).hintColor.withOpacity(.75),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
