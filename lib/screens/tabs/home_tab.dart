import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshelf/controllers/hometab_controller.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/al_type.dart';
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
    double itemHomeHeight = size.height / 3.9;

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

          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: Image.asset('assets/images/png/background.png').image,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: (_ctrl.fetchingAddresses)
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 60),
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
                                                      color: BrandColors
                                                          .colorAccent)),
                                              new TextSpan(
                                                  text:
                                                      'A simple way for you to find \n',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              new TextSpan(
                                                  text: 'Healthy Food ',
                                                  style: TextStyle(
                                                      color: BrandColors
                                                          .colorAccent)),
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
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchPage())),
                                    child:
                                        Icon(Icons.search, color: Colors.white))
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              // here, i'm prinitng the title on tap of the empty space
                              // on the screen, but its returning null
                              print('---- ${_ctrl.getCatList.value.first.title}');

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
                              height: MediaQuery.of(context).size.height * .15,
                              // Here, I'm trying to display the widgets, just like it is on alraad but
                              // it returns null also.

                              // child: ListView(
                              //   scrollDirection: Axis.horizontal,
                              //   children: _ctrl != null
                              //       ? _ctrl.getCatList.value.cat
                              //           .map(
                              //             (AlType category) => GestureDetector(
                              //               onTap: () {},
                              //               child: FoodType(
                              //                   url:
                              //                       'assets/images/svg/rice.svg',
                              //                   title: category.title,
                              //                   color: BrandColors.colorAccent,
                              //                   bgColor:
                              //                       BrandColors.colorAccent),
                              //             ),
                              //           )
                              //           .toList()
                              //       : [],
                              // ),

                              // This is the dummy contents

                              // child: ListView(
                              //   scrollDirection: Axis.horizontal,
                              //   children: [
                              //     FoodType(
                              //         url: 'assets/images/svg/rice.svg',
                              //         title: 'Rice',
                              //         color: BrandColors.colorAccent,
                              //         bgColor: BrandColors.colorAccent),
                              //     FoodType(
                              //         url: 'assets/images/svg/cereal.svg',
                              //         title: 'Cereal and Seeds',
                              //         bgColor: Colors.grey[300]),
                              //     FoodType(
                              //         url: 'assets/images/svg/breakfast.svg',
                              //         title: 'Breakfast Cereals',
                              //         bgColor: Colors.grey[300]),
                              //     FoodType(
                              //         url: 'assets/images/svg/snacks.svg',
                              //         height: 35,
                              //         title: 'Snacks',
                              //         bgColor: Colors.grey[300]),
                              //     FoodType(
                              //         url: 'assets/images/svg/pasta.svg',
                              //         title: 'Pasta and Sauces',
                              //         bgColor: Colors.grey[300]),
                              //     FoodType(
                              //         url: 'assets/images/svg/coffee.svg',
                              //         title: 'Coffee and Tea',
                              //         bgColor: Colors.grey[300]),
                              //   ],
                              // ),
                            ),
                          ),
                          (isVisible)
                              ? Expanded(
                                  child: Container(
                                    child: GridView.count(
                                      crossAxisCount: 4,
                                      childAspectRatio:
                                          (itemWidth / itemHeight),
                                      children: [
                                        // FoodType(
                                        //     url: 'assets/images/svg/rice.svg',
                                        //     title: 'Rice',
                                        //     color: BrandColors.colorAccent,
                                        //     bgColor: BrandColors.colorAccent),
                                        // FoodType(
                                        //     url: 'assets/images/svg/cereal.svg',
                                        //     title: 'Cereal and Seeds',
                                        //     bgColor: Colors.grey[300]),
                                        // FoodType(
                                        //     url: 'assets/images/svg/breakfast.svg',
                                        //     title: 'Breakfast Cereals',
                                        //     bgColor: Colors.grey[300]),
                                        // FoodType(
                                        //     url: 'assets/images/svg/snacks.svg',
                                        //     height: 35,
                                        //     title: 'Snacks',
                                        //     bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/pasta.svg',
                                            title: 'Pasta and Sauces',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/coffee.svg',
                                            title: 'Coffee and Tea',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/oil.svg',
                                            title: 'Oil and Vinegar',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/flour.svg',
                                            title: 'Flour and mixes',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/baking.svg',
                                            title: 'Baking Ingredients',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url:
                                                'assets/images/svg/cooking_ingredients.svg',
                                            title: 'Cooking Ingredients',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/jam.svg',
                                            title: 'Jam and Spread',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/sugar.svg',
                                            title: 'Sugar and Sweetners',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/spices.svg',
                                            title: 'Spices',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/nuts.svg',
                                            title: 'Nuts and Dried Fruits',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url:
                                                'assets/images/svg/quick_meals.svg',
                                            title: 'Quick Meals',
                                            bgColor: Colors.grey[300]),
                                        FoodType(
                                            url: 'assets/images/svg/bread.svg',
                                            title: 'Bread',
                                            bgColor: Colors.grey[300]),
                                      ],
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage()));
                                      },
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            (itemWidth / itemHomeHeight),
                                        children: [
                                          FoodHome(
                                              url:
                                                  'assets/images/png/ricebag.png',
                                              title: 'Brown rice',
                                              subtitle: 'Price: 50 AED',
                                              bgColor: Colors.grey[400]),
                                          FoodHome(
                                              url:
                                                  'assets/images/png/ricebag.png',
                                              title: 'Medium grain rice',
                                              subtitle: 'Price: 55 AED',
                                              bgColor: Colors.grey[400]),
                                          FoodHome(
                                              url:
                                                  'assets/images/png/ricebag.png',
                                              title: 'Long grain rice',
                                              subtitle: 'Price: 40 AED',
                                              bgColor: Colors.grey[400]),
                                          FoodHome(
                                              url:
                                                  'assets/images/png/ricebag.png',
                                              title: 'Short grain rice',
                                              subtitle: 'Price: 45 AED',
                                              bgColor: Colors.grey[400]),
                                        ],
                                      ),
                                    ),
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
