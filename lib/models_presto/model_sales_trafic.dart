class ModelSalesTrafic {
  dynamic date;
  dynamic value;

  ModelSalesTrafic({this.date, this.value});

  ModelSalesTrafic.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['value'] = this.value;
    return data;
  }
}
