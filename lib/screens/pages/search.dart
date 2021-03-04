import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/Search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: Image.asset('assets/images/png/background.png').image,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Search',
                  style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
              SizedBox(height: 20),
              TextField(
                  keyboardType: TextInputType.text,
                  enableSuggestions: true,
                  cursorColor: BrandColors.colorAccent,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText: 'Look for anything...',
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
