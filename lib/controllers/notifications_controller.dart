import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/notifications.dart';
import 'package:foodshelf/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:foodshelf/repository/notifications_repository.dart'
    as notifyRepo;

class NotificationsController extends ControllerMVC {
  NotificationsModel notificationsList = new NotificationsModel();

  ValueNotifier<List<NotificationsModel>> getNotificationsList;

  var fetchingAddresses = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  NotificationsController() {
    getNotificationsList = ValueNotifier(null);

    this.scaffoldKey = new GlobalKey<ScaffoldState>();

    getNotificationList();
  }

  Future getNotificationList() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }

    String uid = await storage.read(key: 'uid');

    IResponse<List<NotificationsModel>> res =
        await notifyRepo.getNotification(uid);
    if (res.statusCode == 200) {
      getNotificationsList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      getNotificationsList.notifyListeners();
      print('///---//-/- ${res.message}');

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

  emptyNotifications(String uid) async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<NotificationsModel> res = await notifyRepo.clearNotifications(uid);

    if (res.statusCode == 200) {
      setState(() {
        fetchingAddresses = false;
        getNotificationsList.value = null;
      });

      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
    } else {
      setState(() {
        fetchingAddresses = false;
      });

      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
    }
  }
}
