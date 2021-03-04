import 'package:foodshelf/helpers/custom_trace.dart';

class Category {
  String id, title, image;

  Category();

  Category.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'];
      title = json['title'];
      image = json['image'];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["title"] = title;
    map["image"] = image;

    return map;
  }
}
