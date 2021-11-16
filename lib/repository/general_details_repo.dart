import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foodshelf/helpers/remote_config.dart';
import 'package:foodshelf/helpers/utility.dart';
import 'package:foodshelf/models/general_details.dart';
import 'package:foodshelf/models/iresponse.dart';
import 'package:http/http.dart' as http;

final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();
final String url = '${_remoteConfigService.getBaseUrl}';

Future<IResponse<GeneralDetails>> getDetails() async {
  try {
    FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    Map<String, String> headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": 'Bearer ${await storage.read(key: 'token')}',
    };

    var res = await http.get(
      Uri.parse("$url/home"),
      headers: headers,
    );

    IResponse<GeneralDetails> alRes = IResponse(
      statusCode: res.statusCode,
      msg: json.decode(res.body)['message'],
      token: json.decode(res.body)['access_token'],
    );

    // TODO: Remove, Inherit from Interceptor
    switch (res.statusCode) {
      case 200:
      case 409:
        alRes.data = GeneralDetails.fromJSON(json.decode(res.body));

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

Future<IResponse<List<GeneralDetails>>> getFaqs() async {
  FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
    "authorization": 'Bearer ${await storage.read(key: 'token')}',
  };

  var res = await http.get(
    Uri.parse("$url/home"),
    headers: headers,
  );
  final Map resData = json.decode(res.body);
  IResponse<List<GeneralDetails>> alRes = IResponse(
    statusCode: res.statusCode,
    message: resData,
  );

  switch (res.statusCode) {
    case 200:
    case 409:
      alRes.data = (resData['faq'] as List)
          .map<GeneralDetails>((item) => GeneralDetails.fromJSON(item))
          .toList();
      break;
    default:
      break;
  }
  return alRes;
}
