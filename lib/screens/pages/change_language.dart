import 'package:flutter/material.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';

class ChangeLanguage extends StatefulWidget {
  static const routeName = '/ChangeLanguage';

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String _language = "";

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
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () {},
                title: 'Save'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change Language',
                    style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                SizedBox(height: 30),
                ListTile(
                  title: const Text('English'),
                  leading: Radio(
                    value: 'English',
                    groupValue: _language,
                    onChanged: (value) {
                      setState(() {
                        _language = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Arabic'),
                  leading: Radio(
                    value: 'Arabic',
                    groupValue: _language,
                    onChanged: (value) {
                      setState(() {
                        _language = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
