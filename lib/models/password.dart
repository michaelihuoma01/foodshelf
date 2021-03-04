
import 'package:foodshelf/helpers/custom_trace.dart';

class HasPassword {
  bool hasPassword;
  String phone, token, password;

  HasPassword();

  HasPassword.fromJSON(Map<String, dynamic> json) {
    try {
      hasPassword = json['has_password'];
      phone = json['phone'];
      token = json['token'];
      password = json['password'];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["has_password"] = hasPassword;
    map["phone"] = phone;
    map["token"] = token;
    map["password"] = password;

    return map;
  }

  @override
  String toString() {
    return this.hasPassword.toString();
  }
}
