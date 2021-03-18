class ModelProductSales {
  dynamic name;
  dynamic qty;
  dynamic total;
  dynamic price;

  ModelProductSales({this.name, this.qty, this.total, this.price});

  ModelProductSales.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
    total = json['total'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['total'] = this.total;
    data['price'] = this.price;
    return data;
  }
}
