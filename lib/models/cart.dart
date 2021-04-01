class Cart {
  String uid, deviceID, productID, qty, total;

  Cart();

  Cart.fromJSON(Map<String, dynamic> json) {
    try {
      uid = json['user_id'].toString();
      deviceID = json['device_id'];
      productID = json['product_id'];
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
    map["product_id"] = productID;
    map["qty"] = qty;
    map["total"] = total;

    return map;
  }
}
