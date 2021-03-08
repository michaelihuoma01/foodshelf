import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshelf/controllers/hometab_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/screens/pages/details.dart';
import 'package:foodshelf/screens/pages/search.dart';
import 'package:foodshelf/utility/brand_colors.dart';
import 'package:foodshelf/widgets/food_home.dart';
import 'package:foodshelf/widgets/food_type.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  static const routeName = '/HomeTab';

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends StateMVC<HomeTab> {
  HomeTabController _ctrl;

  _HomeTabState() : super(HomeTabController()) {
    _ctrl = controller;
  }

  bool isVisible = false;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = size.height / 3;
    double itemWidth = size.width / 2;
    double itemHomeHeight = size.height / 3.5;

    final categoriesListLength = 3;
    var categoriesList = <Widget>[];
    if (_ctrl?.getCatList?.value != null) {
      categoriesList = _ctrl.getCatList.value
          .sublist(0, categoriesListLength)
          .map(
            (Category category) => GestureDetector(
              onTap: () {},
              child: FoodType(url: 'assets/images/svg/rice.svg', title: category.title, color: BrandColors.colorAccent, bgColor: BrandColors.colorAccent),
            ),
          )
          .toList();
    }
    categoriesList.add(GestureDetector(
      onTap: () {},
      child: FoodType(url: 'assets/images/svg/rice.svg', title: 'See All', color: BrandColors.colorAccent, bgColor: BrandColors.colorAccent),
    ));

    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) => _ctrl = context.watch<HomeTabController>(),
          ),
        ],
        builder: (context, child) {
          _ctrl.getCatList.addListener(
            () => Future.delayed(
              Duration(seconds: 1),
              () => setState(
                () {
                  _ctrl.fetchingAddresses = false;
                },
              ),
            ),
          );

          _ctrl.getProdList.addListener(
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
              color: Colors.grey[200],
              // image: DecorationImage(
              //   alignment: Alignment.topCenter,
              //   image: Image.asset('assets/images/png/background.png').image,
              // ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/png/background.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: (_ctrl.fetchingAddresses)
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 60, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: SvgPicture.asset('assets/images/svg/hello.svg'),
                                            )),
                                        SizedBox(width: 10),
                                        Column(
                                          children: [
                                            RichText(
                                              // textAlign: TextAlign.center,
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  new TextSpan(text: 'Hello! \n', style: TextStyle(color: Colors.white)),
                                                  new TextSpan(text: '-- \n', style: TextStyle(color: BrandColors.colorAccent)),
                                                  new TextSpan(text: 'A simple way for you to find \n', style: TextStyle(color: Colors.white)),
                                                  new TextSpan(text: 'Healthy Food ', style: TextStyle(color: BrandColors.colorAccent)),
                                                  new TextSpan(text: 'everyday', style: TextStyle(color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage())), child: Icon(Icons.search, color: Colors.white))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  // here, i'm prinitng the title on tap of the empty space
                                  // on the screen, but its returning null

                                  if (isVisible) {
                                    setState(() {
                                      isVisible = false;
                                    });
                                  } else {
                                    setState(() {
                                      isVisible = true;
                                    });
                                  }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * .16,
                                  // Here, I'm trying to display the widgets, just like it is on alraad but
                                  // it returns null also.

                                  child: ListView(scrollDirection: Axis.horizontal, children: categoriesList),
                                ),
                              ),
                              (isVisible)
                                  ? Expanded(
                                      child: Container(
                                        child: GridView.count(
                                          crossAxisCount: 4,
                                          childAspectRatio: (itemWidth / itemHeight),
                                          children: _ctrl?.getCatList?.value != null
                                              ? _ctrl.getCatList.value
                                                  .map(
                                                    (Category category) => GestureDetector(
                                                      onTap: () {},
                                                      child: FoodType(url: 'assets/images/svg/rice.svg', title: category.title, color: BrandColors.colorAccent, bgColor: BrandColors.colorAccent),
                                                    ),
                                                  )
                                                  .toList()
                                              : [],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage()));
                                          },
                                          child: GridView.count(
                                            crossAxisCount: 2,

                                            children: _ctrl?.getProdList?.value != null
                                                ? _ctrl.getProdList.value
                                                    .map(
                                                      (Category category) => GestureDetector(
                                                        onTap: () {},
                                                        child: FoodHome(url: 'assets/images/png/ricebag.png', title: category.title, subtitle: '${category.price} AED', bgColor: Colors.grey[400]),
                                                      ),
                                                    )
                                                    .toList()
                                                : [],
                                            // FoodHome(
                                            //     url:
                                            //         'assets/images/png/ricebag.png',
                                            //     title: 'Brown rice',
                                            //     subtitle: 'Price: 50 AED',
                                            //     bgColor: Colors.grey[400]),
                                            // FoodHome(
                                            //     url:
                                            //         'assets/images/png/ricebag.png',
                                            //     title: 'Medium grain rice',
                                            //     subtitle: 'Price: 55 AED',
                                            //     bgColor: Colors.grey[400]),
                                            // FoodHome(
                                            //     url:
                                            //         'assets/images/png/ricebag.png',
                                            //     title: 'Long grain rice',
                                            //     subtitle: 'Price: 40 AED',
                                            //     bgColor: Colors.grey[400]),
                                            // FoodHome(
                                            //     url:
                                            //         'assets/images/png/ricebag.png',
                                            //     title: 'Short grain rice',
                                            //     subtitle: 'Price: 45 AED',
                                            //     bgColor: Colors.grey[400]),
                                            // ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
