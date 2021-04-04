import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/notifications.dart';
import 'package:http/http.dart' as http;

final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();

final String url = '${_remoteConfigService.getBaseUrl}';

Future<IResponse<List<NotificationsModel>>> getNotification(String id) async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.get(
    "$url/notifications?user_id=$id",
    headers: headers,
  );
  final Map resData = json.decode(res.body);
  IResponse<List<NotificationsModel>> alRes = IResponse(
    statusCode: res.statusCode,
    message: resData,
  );
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = (resData['notifications'] as List)
          .map<NotificationsModel>((item) => NotificationsModel.fromJSON(item))
          .toList();
      break;
    default:
      break;
  }
  print(res.statusCode);

  return alRes;
}

Future<IResponse<NotificationsModel>> clearNotifications(String uid) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.get(
      "$url/clear-notifications/$uid",
      headers: headers,
    );

    IResponse<NotificationsModel> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );

    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = NotificationsModel.fromJSON(json.decode(res.body));
        break;
      default:
        break;
    }

    return alRes;
  } catch (e) {
    print(e);
    return null;
  }
}
