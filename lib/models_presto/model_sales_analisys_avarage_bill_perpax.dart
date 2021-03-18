class ModelSalesAnalisysByAvarageBillPax {
  dynamic label;
  dynamic value;

  ModelSalesAnalisysByAvarageBillPax({this.label, this.value});

  ModelSalesAnalisysByAvarageBillPax.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}
