import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/cart.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/screens/tabs/cart_tab.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/category_repository.dart' as categoryRepo;

class HomeTabController extends ControllerMVC {
  Category categoryList = new Category();
  Category productsList = new Category();
  Category cartList = new Category();
  Cart cartItem = new Cart();

  ValueNotifier<List<Category>> getCatList;
  ValueNotifier<List<Category>> getProdList;
  ValueNotifier<List<Category>> getCartList;
  String deviceID;

  var fetchingAddresses = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  HomeTabController() {
    getCatList = ValueNotifier(null);
    getProdList = ValueNotifier(null);
    getCartList = ValueNotifier(null);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    getID();
    getCategoryList();
    getProductList();
    getCartItems();
  }

  getID() async {
    deviceID = await storage.read(key: 'deviceID');
    print(deviceID);
  }

  Future getCategoryList() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<List<Category>> res = await categoryRepo.getCategory();
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

  Future getProductList() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<List<Category>> res = await categoryRepo.getProducts();
    if (res.statusCode == 200) {
      getProdList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      getProdList.notifyListeners();

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

  Future getProductDetails(String id) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }

    final res = await categoryRepo.getProductDetails(id: id);
    setState(() {
      fetchingAddresses = true;
    });
    return res;
  }

  addToCart(int uid, String deviceID, productID, qty, total) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Cart> res =
        await categoryRepo.addCart(uid, deviceID, productID, qty, total);

    if (res.statusCode == 200) {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
      setState(() {
        fetchingAddresses = false;
      });
      Navigator.push(scaffoldKey?.currentContext,
          MaterialPageRoute(builder: (context) => CartTab()));
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

  updateCartItem(
      int uid, String deviceID, productID, qty, total, Map products) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Cart> res = await categoryRepo.updateCart(
        uid, deviceID, productID, qty, total, products);

    if (res.statusCode == 200) {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
      setState(() {
        fetchingAddresses = false;
      });
      Navigator.push(scaffoldKey?.currentContext,
          MaterialPageRoute(builder: (context) => CartTab()));
    } else {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: 'res.msg.toString()',
      );
      setState(() {
        fetchingAddresses = false;
      });
      print(res.message.toString());
    }
  }

  Future getCartItems() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    await getID();
    print('>>>>>>>>>>>>>>$deviceID');

    IResponse<List<Category>> res = await categoryRepo.getCart(deviceID);
    if (res.statusCode == 200) {
      getCartList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      getCartList.notifyListeners();
      print('///---//-/- ${res.message}');
      print('///---//-/- ${res.statusCode}');

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

  deleteCartItem(String deviceID, productID) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<Cart> res =
        await categoryRepo.deleteCartItem(deviceID, productID);

    if (res.statusCode == 200) {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
      setState(() {
        fetchingAddresses = false;
        getCartList.value
            .removeWhere((element) => element.productID == productID);
      });
      // Navigator.push(scaffoldKey?.currentContext,
      //     MaterialPageRoute(builder: (context) => MainPage()));
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

  emptyCart(String deviceID) async {
    try {
      if (!fetchingAddresses) {
        setState(() {
          fetchingAddresses = true;
        });
      }
      IResponse<Cart> res = await categoryRepo.clearCart(deviceID);
      print(res.message.toString());

      if (res.statusCode == 200) {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.msg.toString(),
        );
        setState(() {
          fetchingAddresses = false;
          getCartList.value = null;
        });
        // Navigator.push(scaffoldKey?.currentContext,
        //     MaterialPageRoute(builder: (context) => CartTab()));
      } else {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.msg.toString(),
        );
        setState(() {
          fetchingAddresses = false;
        });
        print('/>/>/>>>>>>>>>>//////${res.msg.toString()}');
      }
    } catch (e) {
      print(e);
    }
  }
}
