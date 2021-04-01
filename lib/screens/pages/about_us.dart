import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/general_details_ctrl.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/AboutUs';

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends StateMVC<AboutUs> {
  GeneralDetailsCtrl _ctrl;

  _AboutUsState() : super(GeneralDetailsCtrl()) {
    _ctrl = controller;
  }

  GeneralDetails _data;
  String data;

  void _getData() async {
    final res = await Future.wait<dynamic>([
      _ctrl.getGeneralDetails(),
    ]);
    final IResponse<GeneralDetails> profileResponse = res.first;
    _data = profileResponse.data;

    setState(() {});
    data = _data.aboutus;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

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
        key: _ctrl.scaffoldKey,
        appBar: AppBarWidget(),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () {},
                title: 'Done')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: (data == null)
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About Us',
                          style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                      SizedBox(height: 30),
                      Text('About the app',
                          style: TextStyle(fontFamily: 'Bold')),
                      SizedBox(height: 10),
                      Text(data),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
