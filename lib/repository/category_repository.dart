import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/cart.dart';
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
  return alRes;
}

Future<IResponse<List<Category>>> getCart(String deviceId) async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.get(
    "$url/get-cart?device_id=$deviceId",
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
      alRes.data = (resData['items'] as List)
          .map<Category>((item) => Category.fromJSON(item))
          .toList();
      break;
    default:
      break;
  }
  print(resData);
  return alRes;
}

Future<IResponse<Category>> getProductDetails({
  @required String id,
}) async {
  try {
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
    final Map data = json.decode(res.body);
    final alRespose = IResponse<Category>.fromJson(data);
    if (data['product'] != null && data['product'] is Map) {
      alRespose.data = Category.fromJSON(data['product']);
    }
    return alRespose;
  } catch (e) {
    print('--- getProductDetails error');
    print(e);
    return null;
  }
}

Future<IResponse<Cart>> addCart(
    int uid, String deviceID, productID, qty, total, Map products) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.post(
      "$url/add-to-cart",
      body: json.encode({
        'user_id': uid,
        'device_id': deviceID,
        'product_id': productID,
        'qty': qty,
        'total': total,
        'product': products
      }),
      headers: headers,
    );

    IResponse<Cart> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );

    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = Cart.fromJSON(json.decode(res.body)['message']);
        break;
      default:
        break;
    }

    print(res.statusCode);
    print(res.body);
    return alRes;
  } catch (e) {
    print(e);
  }
}

Future<IResponse<Cart>> updateCart(
    int uid, String deviceID, productID, qty, total, Map products) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.post(
      "$url/update-cart",
      body: json.encode({
        'user_id': uid,
        'device_id': deviceID,
        'product_id': productID,
        'qty': qty,
        'total': total,
        'product': products
      }),
      headers: headers,
    );

    IResponse<Cart> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );

    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = Cart.fromJSON(json.decode(res.body)['message']);
        break;
      default:
        break;
    }

    print(res.statusCode);
    print(res.body);
    return alRes;
  } catch (e) {
    print(e);
  }
}

Future<IResponse<Cart>> deleteCartItem(String deviceID, productID) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.post(
      "$url/delete-cart-item",
      body: json.encode({
        'device_id': deviceID,
        'product_id': productID,
      }),
      headers: headers,
    );

    IResponse<Cart> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );

    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = Cart.fromJSON(json.decode(res.body)['message']);
        break;
      default:
        break;
    }

    print(res.statusCode);
    print(res.body);
    return alRes;
  } catch (e) {
    print(e);
  }
}

Future<IResponse<Cart>> clearCart(String deviceID) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.post(
      "$url/clear-cart",
      body: json.encode({
        'device_id': deviceID,
      }),
      headers: headers,
    );

    IResponse<Cart> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );

    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = Cart.fromJSON(json.decode(res.body)['message']);
        break;
      default:
        break;
    }

    print(res.statusCode);
    print(res.body);
    return alRes;
  } catch (e) {
    print(e);
  }
}
