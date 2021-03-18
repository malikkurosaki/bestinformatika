class ModelHomeIndex {
  dynamic title;
  dynamic today;
  dynamic yesterday;

  ModelHomeIndex({this.title, this.today, this.yesterday});

  ModelHomeIndex.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    today = json['today'];
    yesterday = json['yesterday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['today'] = this.today;
    data['yesterday'] = this.yesterday;
    return data;
  }
}
