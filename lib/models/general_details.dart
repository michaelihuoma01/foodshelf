class GeneralDetails {
  String aboutus,
      serviceCharges,
      deliveryCharges,
      termsCondtions,
      id,
      question,
      answer;

  GeneralDetails();

  GeneralDetails.fromJSON(Map<String, dynamic> json) {
    try {
      aboutus = json['aboutus'];
      serviceCharges = json['service_charges'];
      deliveryCharges = json['delivery_charges'];
      termsCondtions = json['terms_conditions'];

      id = json['id'].toString();
      question = json['question'];
      answer = json['answer'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();

    map["aboutus"] = aboutus;
    map["service_charges"] = serviceCharges;
    map["delivery_charges"] = deliveryCharges;
    map["terms_conditions"] = termsCondtions;

    map['question'] = question;
    map['answer'] = answer;
    map['id'] = id;

    return map;
  }
}
