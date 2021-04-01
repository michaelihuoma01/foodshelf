import 'package:flutter/material.dart';
import 'package:foodshelf/controllers/general_details_ctrl.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/appbar_widget.dart';
import 'package:foodshelf/widgets/button_widget.dart';
import 'package:foodshelf/widgets/food_home.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class Faqs extends StatefulWidget {
  static const routeName = '/FAQs';

  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends StateMVC<Faqs> {
  GeneralDetailsCtrl _ctrl;

  _FaqsState() : super(GeneralDetailsCtrl()) {
    _ctrl = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) =>
                _ctrl = context.watch<GeneralDetailsCtrl>(),
          ),
        ],
        builder: (context, child) {
          _ctrl.getFaqsList.addListener(
            () => Future.delayed(
              Duration(seconds: 1),
              () => setState(
                () {
                  _ctrl.fetchingAddresses = false;
                },
              ),
            ),
          );

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
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      child: TextField(
                          keyboardType: TextInputType.text,
                          enableSuggestions: true,
                          cursorColor: BrandColors.colorAccent,
                          maxLines: null,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintText: 'Ask us anything related to the...',
                              contentPadding: EdgeInsets.all(20),
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                          style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 10),
                    ButtonWidget(
                        color: BrandColors.colorAccent,
                        onPressed: () {},
                        title: 'Submit'),
                  ],
                ),
              ),
              body: (_ctrl.fetchingAddresses)
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 30, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text('FAQS',
                              style:
                                  TextStyle(fontSize: 30, fontFamily: 'Bold')),
                          SizedBox(height: 10),
                          Expanded(
                            child: ListView(
                              children: _ctrl?.getFaqsList?.value != null
                                  ? _ctrl.getFaqsList.value
                                      .map(
                                        (GeneralDetails genDetails) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('● ${genDetails.question}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Medium')),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                  'ANS: ${genDetails.answer}',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      )
                                      .toList()
                                  : [],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
