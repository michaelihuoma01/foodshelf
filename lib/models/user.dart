import 'dart:convert';

import 'package:foodshelf/helpers/custom_trace.dart';

class User {
  // used to indicate if client is logged in or not
  // bool auth;
  // String email, phone, password, uuid, city, username, fullName;
  String email,
      phone,
      password,
      passwordConfirmation,
      uuid,
      name,
      country,
      city;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      email = jsonMap['email'];
      phone = jsonMap['phone'];
      uuid = jsonMap['user_id'];
      name = jsonMap['name'];
      country = jsonMap['country'];
      city = jsonMap['city'];
      password = jsonMap['password'];
      passwordConfirmation = jsonMap['password_confirmation'];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = email;
    map["password"] = password;
    map["password_confirmation"] = passwordConfirmation;
    map["phone"] = phone;
    map["user_id"] = uuid;
    map["name"] = name;
    map["city"] = city;
    map["country"] = country;

    return map;
  }

  Map loginCredentials() {
    var map = new Map<String, dynamic>();
    map["phone"] = phone;
    map["password"] = password;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    // map["auth"] = this.auth;
    return map.toString();
  }
}
