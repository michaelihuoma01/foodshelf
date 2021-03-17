class NotificationsModel {
  String uid, deviceID, title, qty, total;

  NotificationsModel();

  NotificationsModel.fromJSON(Map<String, dynamic> json) {
    try {
      uid = json['user_id'].toString();
      deviceID = json['device_id'];
      title = json['title'];
      qty = json['qty'];
      total = json['total'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["user_id"] = uid;
    map["device_id"] = deviceID;
    map["product_id"] = title;
    map["qty"] = qty;
    map["total"] = total;

    return map;
  }
}
