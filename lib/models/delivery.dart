import 'dart:convert';

import 'package:foodshelf/helpers/custom_trace.dart';

class Delivery {
  String area, building, apartment, country, city, userID, floor;

  Delivery();

  Delivery.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      area = jsonMap['area'];
      building = jsonMap['building'];
      country = jsonMap['country'];
      city = jsonMap['city'];
      floor = jsonMap['floor'];
      apartment = jsonMap['apartment_no'];
      userID = jsonMap['user_id'];
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["area"] = area;
    map["building"] = building;
    map["country"] = country;
    map["city"] = city;
    map["floor"] = floor;
    map["apartment_no"] = apartment;
    map["user_id"] = userID;

    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    // map["auth"] = this.auth;
    return map.toString();
  }
}
