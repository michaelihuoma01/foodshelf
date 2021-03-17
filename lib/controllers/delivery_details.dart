import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/delivery.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
}
