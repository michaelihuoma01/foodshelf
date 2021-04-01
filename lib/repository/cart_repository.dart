// import 'dart:convert';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:foodshelf/helpers/remote_config.dart';
// import 'package:foodshelf/helpers/utility.dart';
// import 'package:foodshelf/models/cart.dart';
// import 'package:foodshelf/models/category.dart';
// import 'package:foodshelf/models/iresponse.dart';
// import 'package:http/http.dart' as http;

// const headers = {
//   "content-type": "application/json",
//   "accept": "application/json",
// };

// final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();
// final String url = '${_remoteConfigService.getBaseUrl}';



// Future<IResponse<Category>> getProductDetails({
//   String id,
// }) async {
//   try {
//     FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

//     Map<String, String> headers = {
//       "content-type": "application/json",
//       "accept": "application/json",
//       "authorization": 'Bearer ${await storage.read(key: 'token')}',
//     };

//     var res = await http.get(
//       "$url/products/$id",
//       headers: headers,
//     );
//     final Map data = json.decode(res.body);
//     final alRespose = IResponse<Category>.fromJson(data);
//     if (data['product'] != null && data['product'] is Map) {
//       alRespose.data = Category.fromJSON(data['product']);
//     }
//     return alRespose;
//   } catch (e) {
//     print('--- getUserProfile error');
//     print(e);
//     return null;
//   }
// }
