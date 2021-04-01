import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/general_details_ctrl.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class TandC extends StatefulWidget {
  static const routeName = '/TandC';

  @override
  _TandCState createState() => _TandCState();
}

class _TandCState extends StateMVC<TandC> {
  GeneralDetailsCtrl _ctrl;

  _TandCState() : super(GeneralDetailsCtrl()) {
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
    data = _data.termsCondtions;
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
        appBar: AppBarWidget(),
        key: _ctrl.scaffoldKey,
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(30),
            child: ButtonWidget(
                color: BrandColors.colorAccent,
                onPressed: () {},
                title: 'Done')),
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
          child: SingleChildScrollView(
            child: (data == null)
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Terms & Conditions',
                          style: TextStyle(fontSize: 30, fontFamily: 'Bold')),
                      SizedBox(height: 30),
                      Text('Our Policy', style: TextStyle(fontFamily: 'Bold')),
                      SizedBox(height: 10),
                      Text(data),
                      SizedBox(height: 20),
                      Text('Regulations', style: TextStyle(fontFamily: 'Bold')),
                      SizedBox(height: 10),
                      Text(
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have Lorem ipsum',
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
