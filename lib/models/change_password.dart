import 'package:foodshelf/helpers/custom_trace.dart';

class ChangePassword {
  String uuid, confirmPassword, newPassword;

  ChangePassword();

  ChangePassword.fromJSON(Map<String, dynamic> json) {
    try {
      confirmPassword = json['confirm_password'];
      newPassword = json['new_password'];
      uuid = json['user_id'];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["confirm_password"] = confirmPassword;
    map["new_password"] = newPassword;
    map["user_id"] = uuid;

    return map;
  }
}
