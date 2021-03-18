class ModelRoomProductionByCity {
  dynamic city;
  dynamic value;

  ModelRoomProductionByCity({this.city, this.value});

  ModelRoomProductionByCity.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['value'] = this.value;
    return data;
  }
}
