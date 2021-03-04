import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/elements/overlay_widget.dart';
import 'package:foodshelf/helpers/constants.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/screens/auth/login.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  BuildContext context;
  Utility.of(BuildContext _context) {
    this.context = _context;
  }

  static void logout(BuildContext context) async {
    // print("In Log out");
    final loader = Utility.load(context);
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    final storage = getIt<FlutterSecureStorage>();
    storage.deleteAll();
    loader.remove();

    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (Route<dynamic> route) => false,
    );
  }

  static Future<Map<String, dynamic>> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(kUserDetailsKey));
  }

  static OverlayEntry load(BuildContext context) {
    return showOverlay(
      context,
      OverlayWidget(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static showMessage(
    BuildContext context, {
    String message,
    IconData iconData,
    MessageTypes type,
    Duration duration,
  }) {
    Flushbar(
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      icon: Icon(
          iconData ?? type == MessageTypes.error
              ? Icons.warning
              : Icons.info_outline,
          color: Colors.white),
      message: message ??
          (type == MessageTypes.error ? 'An Error occurred.' : 'Loading...'),
      duration: duration ?? Duration(seconds: 2),
    )..show(context);
  }

  static OverlayEntry showOverlay(BuildContext context, Widget child) {
    OverlayEntry entry = OverlayEntry(builder: (BuildContext context) => child);
    Overlay.of(context).insert(entry);
    return entry;
  }

  // RegExp Patterns
  static const PhoneRegExp = r'^(?:[+0][1-9])?[0-9]{10,12}$';
}

GetIt getIt = GetIt.instance;

Future setupLocator() async {
  getIt.registerLazySingleton(() => FlutterSecureStorage());
  var remoteConfigService = await RemoteConfigService.getInstance();
  getIt.registerSingleton(remoteConfigService);
}
