import 'package:foodshelf/helpers/custom_trace.dart';
import 'package:foodshelf/models/al_type.dart';

class Category {
  String id, title, image;
  // List<AlType> cat, prod;

  Category() {
    // cat = prod = [];
  }

  Category.fromJSON(Map<String, dynamic> json) {
    try {
      // cat = (jsonMap['categories'] as List)
      //     .map(
      //       (method) => AlType(
      //         id: method['id'],
      //         title: method['title'],
      //       ),
      //     )
      //     .toList();
      id = json['id'];
      title = json['title'];
      image = json['image'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["title"] = title;
    map["image"] = image;

    // map['categories'] = cat;

    return map;
  }
}
