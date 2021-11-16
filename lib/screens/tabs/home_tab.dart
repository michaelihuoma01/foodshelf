import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshelf/controllers/hometab_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/screens/pages/details.dart';
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

  List<Category> filteredList;

  bool isVisible = false, isFiltered = true;
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  String uuid;

  getID() async {
    uuid = await storage.read(key: 'uid');
    print(uuid);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double itemHeight = size.height / 2.5;
    double itemWidth = size.width / 2;
    double itemHomeHeight = size.height / 3.5;

    final categoriesListLength = 3;
    var categoriesList = <Widget>[];
    if (_ctrl?.getCatList?.value != null) {
      categoriesList = _ctrl.getCatList.value
          .sublist(0, categoriesListLength)
          .map(
            (Category category) => GestureDetector(
              onTap: () {
                setState(() {
                  _ctrl.categoryList.title = category.title;
                  _ctrl.categoryList.id = category.id;

                  filteredList = _ctrl.getProdList.value
                      .where((i) => i.categoryID == _ctrl.categoryList.id)
                      .toList();

                  if (isFiltered == true) {
                    isFiltered = false;
                  } else {
                    isFiltered = true;
                  }
                });
              },
              child: FoodType(
                url: 'assets/images/svg/rice.svg',
                title: category.title,
                isSelected: (category.title == _ctrl.categoryList.title),
              ),
            ),
          )
          .toList();
    }
    categoriesList.add(GestureDetector(
      onTap: () {
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
      child: FoodType(
          url: '',
          title: 'See All',
          color: BrandColors.colorAccent,
          bgColor: BrandColors.colorAccent),
    ));

    return MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) =>
                _ctrl = context.watch<HomeTabController>(),
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

          return Stack(
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
                body:
                    //  (_ctrl.fetchingAddresses)
                    //     ? Center(child: CircularProgressIndicator())
                    //     :
                    Padding(
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
                                      child: SvgPicture.asset(
                                          'assets/images/svg/hello.svg'),
                                    )),
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    RichText(
                                      // textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          new TextSpan(
                                              text: 'Hello! \n',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          new TextSpan(
                                              text: '-- \n',
                                              style: TextStyle(
                                                  color:
                                                      BrandColors.colorAccent)),
                                          new TextSpan(
                                              text:
                                                  'A simple way for you to find \n',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          new TextSpan(
                                              text: 'Healthy Food ',
                                              style: TextStyle(
                                                  color:
                                                      BrandColors.colorAccent)),
                                          new TextSpan(
                                              text: 'everyday',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                                child: Icon(Icons.search, color: Colors.white))
                          ],
                        ),
                      ),
                      SizedBox(height: 100),
                      Container(
                        height: MediaQuery.of(context).size.height * .16,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categoriesList),
                      ),
                      (isVisible)
                          ? Expanded(
                              child: Container(
                                child: GridView.count(
                                    crossAxisCount: 4,
                                    childAspectRatio: (itemWidth / itemHeight),
                                    children:
                                        //  _ctrl?.getCatList?.value !=
                                        //         null
                                        //     ?
                                        // _ctrl.getCatList.value
                                        //     .map(
                                        //       (Category category) =>
                                        [
                                      GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   _ctrl.categoryList
                                          //           .title =
                                          //       .title;
                                          // });
                                        },
                                        child: FoodType(
                                          url: 'assets/images/svg/rice.svg',
                                          title: 'title',
                                          isSelected: ('title' ==
                                              _ctrl.categoryList.title),
                                        ),
                                      ),
                                    ]

                                    // .sublist(
                                    //     4,
                                    //     _ctrl.getCatList.value
                                    //         .length)
                                    // : [],
                                    ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                  child: GridView.count(
                                      crossAxisCount: 2,
                                      children: (isFiltered)
                                          ?
                                          // _ctrl?.getProdList?.value != null
                                          //     ?

                                          //  _ctrl.getProdList.value
                                          //     .map(
                                          //       (Category category) =>
                                          [
                                              InkWell(
                                                onTap: () {
                                                  // _ctrl.productsList
                                                  //         .categoryID =
                                                  //     category
                                                  //         .categoryID;

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailsPage(
                                                                  id: 'll')));
                                                },
                                                child: FoodHome(
                                                    url:
                                                        'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322775_2200-800x1200.jpg',
                                                    title: 'Rice',
                                                    subtitle: '${200} AED',
                                                    bgColor: Colors.grey[400]),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // _ctrl.productsList
                                                  //         .categoryID =
                                                  //     category
                                                  //         .categoryID;

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailsPage(
                                                                  id: 'll')));
                                                },
                                                child: FoodHome(
                                                    url:
                                                        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/homemade-bread-horizontal-1547759080.jpg?crop=0.671xw:1.00xh;0.0801xw,0&resize=640:*',
                                                    title: 'Rice',
                                                    subtitle: '${200} AED',
                                                    bgColor: Colors.grey[400]),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // _ctrl.productsList
                                                  //         .categoryID =
                                                  //     category
                                                  //         .categoryID;

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailsPage(
                                                                  id: 'll')));
                                                },
                                                child: FoodHome(
                                                    url:
                                                        'https://www.grandturkishbazaar.com/wp-content/uploads/2020/12/luxury-assorted-turkish-nuts-1.jpg',
                                                    title: 'Mixed Nuts',
                                                    subtitle: '${200} AED',
                                                    bgColor: Colors.grey[400]),
                                              )
                                            ]

                                          // .toList()
                                          // : []
                                          : filteredList != null
                                              ?

                                              // filteredList
                                              //     .map(
                                              //       (Category category) =>
                                              InkWell(
                                                  onTap: () {
                                                    // _ctrl.productsList
                                                    //         .categoryID =
                                                    //     category
                                                    //         .categoryID;

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailsPage(
                                                                    id: 'category')));
                                                  },
                                                  child: FoodHome(
                                                      url:
                                                          'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322775_2200-800x1200.jpg',
                                                      title: 'title',
                                                      subtitle: '${100} AED',
                                                      bgColor:
                                                          Colors.grey[400]),
                                                )
                                              : [])
                                  // .toList()
                                  ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
