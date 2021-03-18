import 'package:probus_mobile/rest_api.dart';

class ModelDailyRevenue {
  dynamic today;
  dynamic mtd;
  dynamic lmd;
  dynamic ytd;
  dynamic title;

  ModelDailyRevenue({this.today, this.mtd, this.lmd, this.ytd, this.title});

  ModelDailyRevenue.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    mtd = json['mtd'];
    lmd = json['lmd'];
    ytd = json['ytd'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today'] = this.today;
    data['mtd'] = this.mtd;
    data['lmd'] = this.lmd;
    data['ytd'] = this.ytd;
    data['title'] = this.title;
    return data;
  }
  
}
