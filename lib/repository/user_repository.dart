import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/contact.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:foodshelf/models/user.dart';
import 'package:http/http.dart' as http;

const headers = {
  "content-type": "application/json",
  "accept": "application/json",
};

final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();
final String url = '${_remoteConfigService.getBaseUrl}';

Future<IResponse<User>> login(User user) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  var res = await http.post(
     Uri.parse("$url/login"),
    body: json.encode(user.loginCredentials()),
    headers: headers,
  );

  IResponse<User> alRes = IResponse(
    statusCode: res.statusCode,
    msg: json.decode(res.body)['message'],
    token: json.decode(res.body)['access_token'],
    uuid: json.decode(res.body)['user_id'],
  );

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = User.fromJSON(json.decode(res.body));
      break;
    default:
      break;
  }

  print(res.statusCode);

  return alRes;
}

Future<IResponse<User>> userSignUp(User user) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  var res = await http.post(
     Uri.parse("$url/signup"),
    body: json.encode(user.toMap()),
    headers: headers,
  );

  final Map data = json.decode(res.body);
  IResponse<User> alRes = IResponse(
      statusCode: res.statusCode,
      message: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token']);

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = User.fromJSON(data['data']);
      // alRes.token = data['access_token'];
      break;
    default:
      break;
  }

  print(res.statusCode);
  print(res.body);

  return alRes;
}

Future<IResponse<ContactModel>> contact(
    String message, name, subject, email) async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.post(
     Uri.parse("$url/contact-us"),
    body: json.encode(
        {'message': message, 'name': name, 'subject': subject, 'email': email}),
    headers: headers,
  );

  final Map data = json.decode(res.body);
  IResponse<ContactModel> alRes = IResponse(
      statusCode: res.statusCode, msg: json.decode(res.body)['message']);

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = ContactModel.fromJSON(data['data']);
      // alRes.token = data['access_token'];
      break;
    default:
      break;
  }

  print(res.statusCode);
  print(res.body);

  return alRes;
}

Future<IResponse<User>> logout(User user) async {
  try {
    final storage = getIt<FlutterSecureStorage>();
    final token = await storage.read(key: 'token');

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
       Uri.parse("$url}/auth/logout"),
      headers: headers,
    );
    final resData = json.decode(res.body);
    return resData['data'].map<User>((item) {
      return User.fromJSON(item);
    }).toList();
  } catch (e) {
    print('--- getUserAddress error');
    print(e);
    return null;
  }
}

Future<IResponse<User>> forgotPassword(String phone) async {
  final storage = getIt<FlutterSecureStorage>();
  final token = await storage.read(key: 'token');

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "Authorization": "Bearer $token",
  };

  var res = await http.post(
    Uri.parse( "$url/forgot-password"),
    body: json.encode({'phone': phone}),
    headers: headers,
  );

  IResponse<User> alRes = IResponse(
    statusCode: res.statusCode,
    message: json.decode(res.body),
  );

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = User.fromJSON(json.decode(res.body));
      break;
    default:
      break;
  }

  print(res.statusCode);
  print(res.body);

  return alRes;
}

Future<IResponse<User>> verifyToken(String code) async {
  final storage = getIt<FlutterSecureStorage>();
  final token = await storage.read(key: 'token');

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "Authorization": "Bearer $token",
  };

  var res = await http.post(
     Uri.parse("$url/verify-code"),
    body: json.encode({'code': code}),
    headers: headers,
  );

  IResponse<User> alRes = IResponse(
    statusCode: res.statusCode,
    message: json.decode(res.body),
  );

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = User.fromJSON(json.decode(res.body));
      break;
    default:
      break;
  }

  print(res.statusCode);
  print(res.body);

  return alRes;
}

Future<IResponse<User>> resetPassword(
    String password, passwordConfirmation, userID) async {
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  var res = await http.post(
     Uri.parse("$url/reset-password"),
    body: json.encode({
      'password': password,
      'password_confirmation': passwordConfirmation,
      'user_id': userID
    }),
    headers: headers,
  );

  IResponse<User> alRes = IResponse(
    statusCode: res.statusCode,
    message: json.decode(res.body),
  );

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = User.fromJSON(json.decode(res.body));
      break;
    default:
      break;
  }

  print(res.statusCode);
  print(res.body);

  return alRes;
}

Future<IResponse<User>> updateProfileDetails(
    String name, phone, country, city, uid) async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.post(
       Uri.parse("$url/update"),
      body: json.encode({
        'name': name,
        'phone': phone,
        'country': country,
        'city': city,
        'user_id': uid,
      }),
      headers: headers,
    );

    IResponse<User> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );
    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = User.fromJSON(json.decode(res.body));
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

Future<IResponse<User>> getUser() async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.get(
       Uri.parse("$url/user"),
      headers: headers,
    );
    final Map data = json.decode(res.body);
    final alRespose = IResponse<User>.fromJson(data);
    if (data != null && data is Map) {
      alRespose.data = User.fromJSON(data);
    }
    return alRespose;
  } catch (e) {
    print('--- getUserDetails error');
    print(e);
    return null;
  }
}

Future<IResponse<User>> changePassword(
    String oldPassword, newPassword, confirmPassword, uid) async {
  final storage = getIt<FlutterSecureStorage>();
  final token = await storage.read(key: 'token');

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "Authorization": "Bearer $token",
  };

  var res = await http.post(
    Uri.parse( "$url/change-password"),
    body: json.encode({
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_password': confirmPassword,
      'user_id': uid
    }),
    headers: headers,
  );

  IResponse<User> alRes = IResponse(
    statusCode: res.statusCode,
    msg: json.decode(res.body)['message'],
  );

  // TODO: Remove, Inherit from Interceptor
  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = User.fromJSON(json.decode(res.body));
      break;
    default:
      break;
  }

  print(res.statusCode);
  print(res.body);

  return alRes;
}
