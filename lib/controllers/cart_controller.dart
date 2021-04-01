// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:foodshelf/helpers/utility.dart';
// import 'package:foodshelf/models/cart.dart';
// import 'package:foodshelf/models/category.dart';
// import 'package:foodshelf/models/iresponse.dart';
// import 'package:foodshelf/repository/cart_repository.dart' as cart_repo;
// import 'package:mvc_pattern/mvc_pattern.dart';

// class CartController extends ControllerMVC {
//   Cart cart = new Cart();

//   Category productsList = new Category();
//   ValueNotifier<List<Category>> getProdList;

//   var fetchingAddresses = true;
//   GlobalKey<ScaffoldState> scaffoldKey;
//   OverlayEntry verificationOverlay, loader;
//   FlutterSecureStorage storage;

//   CartController() {
//     getProdList = ValueNotifier(null);

//     this.scaffoldKey = new GlobalKey<ScaffoldState>();
//   }

 
//   Future getProductDetails(String id) async {
//     if (!fetchingAddresses) {
//       setState(() {
//         fetchingAddresses = true;
//       });
//     }

//     final res = await cart_repo.getProductDetails(id: id);
//     setState(() {
//       fetchingAddresses = true;
//     });
//     return res;
//   }
// }
