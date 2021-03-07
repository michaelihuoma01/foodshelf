class Category {
  String id, title, image, price, qty, categoryID, sku, description, status;

  Category();

  Category.fromJSON(Map<String, dynamic> json) {
    try {
      print('--- $json');
      id = json['id'].toString();
      title = json['title'];
      image = json['image'];
      price = json['price'];
      qty = json['qty'];
      categoryID = json['category_id'];
      description = json['description'];
      status = json['status'];
      sku = json['sku'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["id"] = id;
    map["title"] = title;
    map["image"] = image;
    map["price"] = price;
    map["qty"] = qty;
    map["category_id"] = categoryID;
    map["description"] = description;
    map["status"] = status;
    map["sku"] = sku;

    return map;
  }
}
