import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/category.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:http/http.dart' as http;

final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();

final String url = '${_remoteConfigService.getBaseUrl}';

Future<IResponse<List<Category>>> getCategory() async {
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
  final Map resData = json.decode(res.body);
  IResponse<List<Category>> alRes = IResponse(
    statusCode: res.statusCode,
    message: resData,
  );
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = (resData['categories'] as List)
          .map<Category>((item) => Category.fromJSON(item))
          .toList();
      break;
    default:
      break;
  }
  print(res.statusCode);
  print(json.decode(res.body));
  // print(alRes.data.title);

  return alRes;
}

Future<IResponse<List<Category>>> getProducts() async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.get(
    "$url/products",
    headers: headers,
  );
  final Map resData = json.decode(res.body);
  IResponse<List<Category>> alRes = IResponse(
    statusCode: res.statusCode,
    message: resData,
  );
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = (resData['products'] as List)
          .map<Category>((item) => Category.fromJSON(item))
          .toList();
      break;
    default:
      break;
  }
  print(res.statusCode);
  // print(json.decode(res.body));
  // print(alRes.data.title);

  return alRes;
}

Future<IResponse<List<Category>>> getProductDetails({
  @required String id,
}) async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.get(
    "$url/products/$id",
    headers: headers,
  );
  final Map resData = json.decode(res.body);
  IResponse<List<Category>> alRes = IResponse(
    statusCode: res.statusCode,
    message: resData,
  );
  switch (res.statusCode) {
    case 200:
    case 409:
      // alRes.data = (resData as List)
      //     .map<Category>((item) => Category.fromJSON(item))
      //     .toList();

      Map<String, dynamic> map = json.decode(res.body);

      alRes.data = map.entries.map((entry) => Category()).toList();

      // List<dynamic> data = map["product"];
      print('-------///////--------${alRes.data}');
      break;
    default:
      break;
  }
  print(res.statusCode);
  // print(json.decode(res.body));
  // print(alRes.data.title);

  return alRes;
}
