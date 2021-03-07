import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshelf/utility/brand_colors.dart';

class FoodHome extends StatefulWidget {
  final String url, title, subtitle;
  final Color bgColor, color;
  final double height;

  FoodHome(
      {this.title,
      this.url,
      this.bgColor,
      this.color,
      this.height,
      this.subtitle});
  @override
  _FoodHomeState createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular((18))),
            child: Image.asset(widget.url),
          ),
          SizedBox(height: 3),
          Expanded(
              child: Text(widget.title,
                  style: TextStyle(fontSize: 15), textAlign: TextAlign.center)),
          Container(
              decoration: BoxDecoration(
                color: BrandColors.colorAccent,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Text(widget.subtitle,
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center))),
          SizedBox(height: 5),
        ]),
      ),
    );
  }
}
