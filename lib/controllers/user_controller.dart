import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/constants.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/contact.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/user.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:foodshelf/screens/auth/new_password.dart';
import 'package:foodshelf/screens/auth/verification.dart';
import 'package:foodshelf/screens/main_page.dart';
import 'package:foodshelf/repository/user_repository.dart' as user_repo;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  User user = new User();
  ContactModel contact = new ContactModel();
  // VerifyToken verify = new VerifyToken();
  String confirmedPassword;
  String token;

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey, registerFormKey;
  OverlayEntry verificationOverlay, loader;
  FlutterSecureStorage storage;
  var fetchingAddresses = true;
  ValueNotifier<User> getDetails;

  TextEditingController addressField = TextEditingController();

  bool verificationActive = false, autoValidate = false, hidePassword = true;

  PageController pageController = PageController(initialPage: 0);

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    registerFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    storage = getIt<FlutterSecureStorage>();

    getDetails = ValueNotifier(null);

    getUserProfile();
  }

  Future<String> _getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      storage.write(key: "deviceID", value: iosDeviceInfo.identifierForVendor);
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      storage.write(key: "deviceID", value: androidDeviceInfo.androidId);
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  login() async {
    try {
      loader = Utility.load(scaffoldKey?.currentContext);

      IResponse<User> res = await user_repo.login(user);

      if (res.statusCode == 200) {
        storage.write(key: "token", value: res.token);
        storage.write(key: "uid", value: res.data.uuid);
        setUserDetails(res.data);
        _getDeviceId();
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
    } catch (e) {
      print(e);
    }
  }

  void register() async {
    loader = Utility.load(scaffoldKey?.currentContext);

    print(user.toMap());

    IResponse<User> res = await user_repo.userSignUp(user);

    if (res.statusCode == 200) {
      storage.write(key: "token", value: res.token);
      storage.write(key: "name", value: res.data.name);
      storage.write(key: "email", value: res.data.email);
      storage.write(key: "password", value: res.data.password);
      _getDeviceId();
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

  verify(String code) async {
    try {
      loader = Utility.load(scaffoldKey?.currentContext);
      IResponse<User> res = await user_repo.verifyToken(code);

      if (res.statusCode == 200) {
        Navigator.push(scaffoldKey?.currentContext,
            MaterialPageRoute(builder: (context) => NewPasswordPage()));
        loader.remove();
      } else {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.message.toString(),
        );
        loader.remove();
      }
    } catch (e) {
      print(e);
    }
  }

  forgotPass(String phone) async {
    try {
      loader = Utility.load(scaffoldKey?.currentContext);

      IResponse<User> res = await user_repo.forgotPassword(phone);

      if (res.statusCode == 200) {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.msg.toString(),
        );
        Navigator.push(scaffoldKey?.currentContext,
            MaterialPageRoute(builder: (context) => VerificationPage()));
        loader.remove();
      } else {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.message.toString(),
        );
        loader.remove();
      }
    } catch (e) {
      print(e);
    }
  }

  resetPass(String password, passwordConfirmation, uid) async {
    try {
      loader = Utility.load(scaffoldKey?.currentContext);

      IResponse<User> res =
          await user_repo.resetPassword(password, passwordConfirmation, uid);

      if (res.statusCode == 200) {
        Navigator.push(scaffoldKey?.currentContext,
            MaterialPageRoute(builder: (context) => LoginPage()));
        loader.remove();
      } else {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.message.toString(),
        );
        loader.remove();
      }
    } catch (e) {
      print(e);
    }
  }

  // Future getUserProfile() async {
  //   if (!fetchingAddresses) {
  //     setState(() {
  //       fetchingAddresses = true;
  //     });
  //   }

  //   IResponse<User> res = await user_repo.getUser();
  //   if (res.statusCode == 200) {
  //     getDetails.value = res.data;

  //     // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  //     getDetails.notifyListeners();
  //     print('///---//-/- ${res.message}');
  //     print('///---//-/- ${res.statusCode}');

  //     setState(() {
  //       fetchingAddresses = false;
  //     });
  //   } else {
  //     print(res.toString());

  //     setState(() {
  //       fetchingAddresses = false;
  //     });
  //   }
  // }
  Future getUserProfile() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }

    final res = await user_repo.getUser();
    setState(() {
      fetchingAddresses = true;
    });
    return res;
  }

  updateProfile(String uid, name, phone, email, country, city) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<User> res =
        await user_repo.updateProfile(uid, name, phone, email, country, city);

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

  void contactUs() async {
    loader = Utility.load(scaffoldKey?.currentContext);

    IResponse<ContactModel> res = await user_repo.contact(contact);

    if (res.statusCode == 200) {
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

  changePass(String oldPassword, newPassword, confirmPassword, uid) async {
    try {
      loader = Utility.load(scaffoldKey?.currentContext);

      IResponse<User> res = await user_repo.changePassword(
          oldPassword, newPassword, confirmPassword, uid);

      if (res.statusCode == 200) {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.msg.toString(),
        );
        loader.remove();
      } else {
        Utility.showMessage(
          scaffoldKey?.currentContext,
          message: res.msg.toString(),
        );
        loader.remove();
      }
    } catch (e) {
      print(e);
    }
  }
}
