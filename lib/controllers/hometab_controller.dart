import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/category_repository.dart' as categoryRepo;

class HomeTabController extends ControllerMVC {
  ValueNotifier<Category> categoryList;
  var fetchingAddresses = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeTabController() {
    categoryList = ValueNotifier(Category());
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    getCategoryList();
  }

  Future getCategoryList() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Category> res = await categoryRepo.getConfig();
    if (res.statusCode < 300 || res.statusCode == 409) {
      categoryList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      categoryList.notifyListeners();
      print(res.data.toString());

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
