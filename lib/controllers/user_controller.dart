import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/constants.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/user.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/repository/user_repository.dart' as user_repo;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  User user = new User();
  // VerifyToken verify = new VerifyToken();
  String confirmedPassword;

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey, registerFormKey;
  OverlayEntry verificationOverlay, loader;
  FlutterSecureStorage storage;
  TextEditingController addressField = TextEditingController();

  bool verificationActive = false, autoValidate = false, hidePassword = true;

  PageController pageController = PageController(initialPage: 0);

  UserController({bool withFileCtrl = false}) {
    loginFormKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    storage = getIt<FlutterSecureStorage>();
  }

  login() async {
    // if (loginFormKey.currentState.validate()) {
    loader = Utility.load(scaffoldKey?.currentContext);

    IResponse<User> res = await user_repo.login(user);

    if (res.statusCode == 200) {
      storage.write(key: "token", value: res.token);
      storage.write(key: "name", value: res.data.name);
      storage.write(key: "phoneNumber", value: res.data.phone);
      setUserDetails(res.data);
      Navigator.of(scaffoldKey?.currentContext).pushReplacementNamed(
        MainPage.routeName,
        arguments: 0,
      );
      loader.remove();
    } else {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.message.toString(),
      );
      loader.remove();
    }
    // } else {
    //   setState(() => autoValidate = true);
    // }
  }

  // void verifyToken() async {
  //   loader = Utility.load(scaffoldKey?.currentContext);
  //   // dismissVerification();

  //   IResponse<VerifyToken> vRes =
  //       await user_repo.verifyToken(verify, scaffoldKey?.currentContext);
  //   if (vRes.status == true) {
  //     // Navigator.push(scaffoldKey?.currentContext,
  //     //     MaterialPageRoute(builder: (context) => LoginScreen()));
  //     pageController.nextPage(
  //         duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  //     Utility.showMessage(
  //       scaffoldKey?.currentContext,
  //       message: 'OTP Verified!',
  //     );
  //     loader.remove();
  //   } else {
  //     Utility.showMessage(
  //       scaffoldKey?.currentContext,
  //       message: vRes.message,
  //     );
  //     loader.remove();
  //   }
  // }

  void register() async {
    loader = Utility.load(scaffoldKey?.currentContext);

    print(user.toMap());

    IResponse<User> res = await user_repo.userSignUp(user);

    if (res.statusCode == 200) {
      storage.write(key: "token", value: res.token);
      storage.write(key: "name", value: res.data.name);
      storage.write(key: "email", value: res.data.email);
      storage.write(key: "password", value: res.data.password);
      setUserDetails(res.data);
      Navigator.of(scaffoldKey?.currentContext).pushNamedAndRemoveUntil(
        MainPage.routeName,
        (route) => false,
      );
      loader.remove();
    } else {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.message.toString(),
        type: MessageTypes.error,
      );
      loader.remove();
    }
  }

  void toNextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void setUserDetails(User user) async {
    final userDetails = {
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
      'password': user.password
    };
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUserDetailsKey, json.encode(userDetails));
  }

  void updateUserDetails(User user) async {
    final userDetails = {
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
      'password': user.password
    };
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(kUserDetailsKey, json.encode(userDetails));
  }

  void togglePasswordVisibility() {
    setState(() => hidePassword = !hidePassword);
  }
}
