class ModelForeCastOccupancy {
  dynamic month;
  dynamic occupancy;

  ModelForeCastOccupancy({this.month, this.occupancy});

  ModelForeCastOccupancy.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    occupancy = json['occupancy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['occupancy'] = this.occupancy;
    return data;
  }
}
