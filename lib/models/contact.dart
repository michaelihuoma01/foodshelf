import 'dart:convert';

import 'package:foodshelf/helpers/custom_trace.dart';

class ContactModel {
  // used to indicate if client is logged in or not
  // bool auth;
  // String email, phone, password, uuid, city, username, fullName;
  String email, subject, fname, lname, message;

  ContactModel();

  ContactModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      email = jsonMap['email'];
      fname = jsonMap['first_name'];
      lname = jsonMap['last_name'];
      subject = jsonMap['subject'];
      message = jsonMap['message'];
    } catch (e) {
      // print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = email;
    map["subject"] = subject;
    map["message"] = message;
    map["first_name"] = fname;
    map["last_name"] = lname;

    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    // map["auth"] = this.auth;
    return map.toString();
  }
}
