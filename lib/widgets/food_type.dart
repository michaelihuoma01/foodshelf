import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodType extends StatefulWidget {
  final String url, title;
  final Color bgColor, color;
  final double height;

  FoodType({this.title, this.url, this.bgColor, this.color, this.height});
  @override
  _FoodTypeState createState() => _FoodTypeState();
}

class _FoodTypeState extends State<FoodType> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(widget.url,
                        color: widget.color, height: 20,),
                  )),
              SizedBox(height: 6),
              Expanded(
                  child: Text(widget.title,
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }
}
