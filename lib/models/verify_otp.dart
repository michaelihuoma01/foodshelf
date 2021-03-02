import 'package:foodshelf/helpers/custom_trace.dart';

class VerifyToken {
  String email, token;

  VerifyToken();

  VerifyToken.fromJSON(Map<String, dynamic> json) {
    try {
      email = json['email'];
      token = json['token'];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["email"] = email;
    map["token"] = token;

    return map;
  }

  // @override
  // String toString() {
  //   return this.hasPassword.toString();
  // }
}
