import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/category_repository.dart' as categoryRepo;

class HomeTabController extends ControllerMVC {
  Category categoryList = new Category();
  ValueNotifier<Category> getCatList;

  var fetchingAddresses = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeTabController() {
    getCatList = ValueNotifier(Category());
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    getCategoryList();
  }

  Future getCategoryList() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Category> res = await categoryRepo.getCategory();
    if (res.statusCode == 200) {
      getCatList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      getCatList.notifyListeners();
      print(res.data);

      setState(() {
        fetchingAddresses = false;
      });
    } else {
      print(res.toString());

      setState(() {
        fetchingAddresses = false;
      });
    }
  }
}
