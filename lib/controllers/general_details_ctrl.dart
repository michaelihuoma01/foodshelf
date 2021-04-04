import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/general_details_repo.dart' as general_repo;

class GeneralDetailsCtrl extends ControllerMVC {
  GeneralDetails details = new GeneralDetails();

  var fetchingAddresses = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  ValueNotifier<List<GeneralDetails>> getFaqsList;

  GeneralDetailsCtrl() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getFaqsList = ValueNotifier(null);

    getFaq();
  }

  Future getGeneralDetails() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }

    final res = await general_repo.getDetails();
    setState(() {
      fetchingAddresses = false;
    });
    return res;
  }

  Future getFaq() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<List<GeneralDetails>> res = await general_repo.getFaqs();
    if (res.statusCode == 200) {
      getFaqsList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      getFaqsList.notifyListeners();
      print('>>>>>>>>///////////////${getFaqsList.value.first.id}');

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
