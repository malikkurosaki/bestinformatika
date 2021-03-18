class ModelReportOverviewAndBestDay {
  dynamic label;
  dynamic value;

  ModelReportOverviewAndBestDay({this.label, this.value});

  ModelReportOverviewAndBestDay.fromJson(Map<String, dynamic> json) {
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
