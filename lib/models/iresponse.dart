class IResponse<T> {
  int statusCode;
  String message, token;
  T data;
  bool status;
  Map<String, String> error;
  Meta meta;

  IResponse({
    this.data,
    this.token,
    this.message,
    this.statusCode,
    this.status,
  });

  IResponse.fromJson(Map<String, dynamic> json, {T data}) {
    status = json['status'];
    if (json['error'] != null && json['error'] is Map) {
      error = {};
      print(json['error']);

      (json['error'] as Map).forEach((key, value) {
        if (value is String) {
          error[key] = value;
        } else if (value is List && value.isNotEmpty) {
          error[key] = value.first;
        }
      });
    }
    this.data = data;
    message = json['message'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["data"] = data;
    map["token"] = token;
    map["message"] = message;
    map["status_code"] = statusCode;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}

class Meta {
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  String next;
  String previous;

  Meta({
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.next,
    this.previous,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    return data;
  }
}
