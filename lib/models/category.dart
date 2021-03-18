class Category {
  String id,
      productID,
      title,
      image,
      price,
      qty,
      categoryID,
      sku,
      description,
      status;

  Category();

  Category.fromJSON(Map<String, dynamic> json) {
    try {
      id = json['id'].toString();
      title = json['title'];
      image = json['image'];
      price = json['price'];
      qty = json['qty'];
      categoryID = json['category_id'];
      description = json['description'];
      status = json['status'];
      sku = json['sku'];

      if (json['product'] != null) {
        title = json['product']['title'];
        image = json['product']['image'];
        productID = json['product']['id'].toString();
        description = json['product']['description'];
      }
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

    if (map['product'] != null) {
      map['product']['title'] = title;
      map['product']['image'] = image;
      map['product']['id'] = productID;
      map['product']['description'] = description;
    }

    return map;
  }
}
