class ModelRoomProductionByCountry {
  dynamic country;
  dynamic value;

  ModelRoomProductionByCountry({this.country, this.value});

  ModelRoomProductionByCountry.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['value'] = this.value;
    return data;
  }
}
