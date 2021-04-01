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
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular((18))),
              child: Image.network(widget.url,
                  height: 100, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 5),
            Expanded(
                child: Text(widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center)),
            Container(
                decoration: BoxDecoration(
                  color: BrandColors.colorAccent.withOpacity(0.6),
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
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    )),
                SizedBox(height: 5),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child:
                          Icon(Icons.favorite, color: Colors.white, size: 20),
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
