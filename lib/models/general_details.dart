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
      if (json['faq'] != null) {
        id = json['faq']['id'].toString();
        question = json['faq']['question'];
        answer = json['faq']['answer'];
      }
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

    if (map['faq'] != null) {
      map['faq']['question'] = question;
      map['faq']['answer'] = answer;
      map['faq']['id'] = id;
    }
    return map;
  }
}
