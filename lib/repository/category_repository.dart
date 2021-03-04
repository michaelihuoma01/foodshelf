import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:http/http.dart' as http;

Category categoryList = Category();

final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();

final String url = '${_remoteConfigService.getBaseUrl}';

Future<IResponse<Category>> getConfig() async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": '${await storage.read(key: 'token')}',
  };

  print(headers.toString());

  var res = await http.get(
    "$url/categories",
    headers: headers,
  );

  IResponse<Category> alRes = IResponse(
    statusCode: res.statusCode,
    message: json.decode(res.body)['categories'],
  );
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = Category.fromJSON(json.decode(res.body)['data']);
      break;
    default:
      break;
  }
  print(res.statusCode);
  print(res.body);

  return alRes;
}
