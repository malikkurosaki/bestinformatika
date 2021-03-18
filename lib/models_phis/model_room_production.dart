class ModelRoomProduction {
  dynamic kdAgen;
  dynamic nmAgen;
  dynamic value;

  ModelRoomProduction({this.kdAgen, this.nmAgen, this.value});

  ModelRoomProduction.fromJson(Map<String, dynamic> json) {
    kdAgen = json['kd_agen'];
    nmAgen = json['nm_agen'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_agen'] = this.kdAgen;
    data['nm_agen'] = this.nmAgen;
    data['value'] = this.value;
    return data;
  }
}
