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
      "$url/home",
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
        alRes.data = GeneralDetails.fromJSON(json.decode(res.body)['faq']);

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
