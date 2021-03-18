class ModelTransactionSummary {
  dynamic type;
  dynamic qty;
  dynamic net;

  ModelTransactionSummary({this.type, this.qty, this.net});

  ModelTransactionSummary.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    qty = json['qty'];
    net = json['net'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['qty'] = this.qty;
    data['net'] = this.net;
    return data;
  }
}
