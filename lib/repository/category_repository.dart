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

Future<IResponse<Category>> getCategory() async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.get(
    "$url/categories",
    headers: headers,
  );

  IResponse<Category> alRes = IResponse(
    statusCode: res.statusCode,
    message: json.decode(res.body),
  );
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = Category.fromJSON(json.decode(res.body));
      break;
    default:
      break;
  }
  print(res.statusCode);
  print(json.decode(res.body));
  print(alRes.data.title);

  return alRes;
}
