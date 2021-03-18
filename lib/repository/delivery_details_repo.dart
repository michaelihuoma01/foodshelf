import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/delivery.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:http/http.dart' as http;

const headers = {
  "content-type": "application/json",
  "accept": "application/json",
};

final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();
final String url = '${_remoteConfigService.getBaseUrl}';

Future<IResponse<Delivery>> deliveryDetails(
    String area, building, country, city, uid, floor, apartment) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.post(
      "$url/delivery-details",
      body: json.encode({
        'area': area,
        'building': building,
        'country': country,
        'city': city,
        'user_id': uid,
        'floor': floor,
        'apartment_no': apartment,
      }),
      headers: headers,
    );

    IResponse<Delivery> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );
    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = Delivery.fromJSON(json.decode(res.body));
        break;
      default:
        break;
    }

    print(res.statusCode);
    print(res.body);
    return alRes;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<IResponse<Delivery>> getDelivryAddress() async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    String uuid = await storage.read(key: 'uid');

    var res = await http.get(
      "$url/delivery-details/$uuid",
      headers: headers,
    );
    final Map data = json.decode(res.body);
    final alRespose = IResponse<Delivery>.fromJson(data);
    if (data['details'] != null && data['details'] is Map) {
      alRespose.data = Delivery.fromJSON(data['details']);
    }

    return alRespose;
  } catch (e) {
    print('--- getDeliveryDetails error');
    print(e);
    return null;
  }
}
