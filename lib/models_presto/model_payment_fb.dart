class ModelPaymentFb {
  dynamic id;
  dynamic type;
  dynamic value;

  ModelPaymentFb({this.id, this.type, this.value});

  ModelPaymentFb.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
