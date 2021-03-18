import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/general_details_repo.dart' as general_repo;

class GeneralDetailsCtrl extends ControllerMVC {
  GeneralDetails details = new GeneralDetails();

  var fetchingAddresses = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  GeneralDetailsCtrl() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future getGeneralDetails() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }

    final res = await general_repo.getDetails();
    setState(() {
      fetchingAddresses = true;
    });
    return res;
  }
}
