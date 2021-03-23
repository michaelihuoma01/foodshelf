class NotificationsModel {
  String uid, id, image, description, source, title;

  NotificationsModel();

  NotificationsModel.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'].toString();
      uid = json['user_id'];
      title = json['title'];
      description = json['description'];
      image = json['image'];
      source = json['source'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["user_id"] = uid;
    map["title"] = title;
    map["description"] = description;
    map["image"] = image;
    map["source"] = source;
    return map;
  }
}
