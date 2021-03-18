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
    getDlvryAddress();
  }

  Future getDlvryAddress() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    final res = await delivery_repo.getDelivryAddress();
    setState(() {
      fetchingAddresses = false;
    });

    return res;
  }

  dlvryDetails(
      String area, building, country, city, userID, floor, apartment) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Delivery> res = await delivery_repo.deliveryDetails(
        area, building, country, city, userID, floor, apartment);

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
