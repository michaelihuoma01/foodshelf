import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/delivery.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/delivery_details_repo.dart'
    as delivery_repo;

class DeliveryDetailsCtrl extends ControllerMVC {
  Delivery dlvry = new Delivery();

  GlobalKey<ScaffoldState> scaffoldKey;
  OverlayEntry verificationOverlay, loader;
  FlutterSecureStorage storage;
  var fetchingAddresses = true;

  DeliveryDetailsCtrl() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    storage = getIt<FlutterSecureStorage>();
    // getUserProfile();
  }

  dlvryDetails(
      String area, building, apartment, country, city, userID, floor) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Delivery> res = await delivery_repo.deliveryDetails(
        area, building, apartment, country, city, userID, floor);

    if (res.statusCode == 200) {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
      setState(() {
        fetchingAddresses = false;
      });
    } else {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
      setState(() {
        fetchingAddresses = false;
      });
      print(res.message.toString());
    }
  }
}
