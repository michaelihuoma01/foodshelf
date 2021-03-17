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
  String deviceID;

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
    print('>>>>>>>>>>>>>>$deviceID');

    IResponse<List<NotificationsModel>> res =
        await notifyRepo.getNotification();
    if (res.statusCode == 200) {
      getNotificationsList.value = res.data;

      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      getNotificationsList.notifyListeners();
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

  emptyNotifications() async {
    if (!fetchingAddresses) {
      setState(() {
        fetchingAddresses = true;
      });
    }
    IResponse<NotificationsModel> res = await notifyRepo.clearNotifications();
    print(res.message.toString());

    if (res.statusCode == 200) {
      Utility.showMessage(
        scaffoldKey?.currentContext,
        message: res.msg.toString(),
      );
      setState(() {
        fetchingAddresses = false;
        getNotificationsList.value = null;
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
      print(res.message.toString());
    }
  }
}
