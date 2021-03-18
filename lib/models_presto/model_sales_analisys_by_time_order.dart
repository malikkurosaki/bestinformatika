class ModelSalesAnalisysByTimeOrder {
  dynamic label;
  dynamic value;
  dynamic start;
  dynamic finish;

  ModelSalesAnalisysByTimeOrder(
      {this.label, this.value, this.start, this.finish});

  ModelSalesAnalisysByTimeOrder.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    start = json['start'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['start'] = this.start;
    data['finish'] = this.finish;
    return data;
  }
}
