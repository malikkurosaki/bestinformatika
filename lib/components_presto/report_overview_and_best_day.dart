import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:probus_mobile/models_presto/model_report_overview_and_best_day.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';

import 'master/master_date.dart';
import 'master/master_dept.dart';

class ReportOverviewAndBestDay extends Bantuan{
  static final lsData = <ModelReportOverviewAndBestDay>[].obs;
  static final load = false.obs;
  final bool denganJudul;

  ReportOverviewAndBestDay({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul??false,
    onFinis: () => 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          child: Wrap(
            children: [
              MasterDate((_) => init()),
              MasterDept((_) => init())
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              for(final ls in lsData)
              Container(
                color: Colors.grey[300],
                margin: EdgeInsets.all(1),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.amber,
                      padding: EdgeInsets.all(4),
                      child: Text(ls?.label?.toString(),).boldPutih,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Icon(
                            Icons.dashboard_outlined,
                            color: Colors.grey[200],
                            size: 53,
                          ),
                          Container(
                            child: Center(
                              child: Text(ls?.value?.toString()).bold
                            ),
                          ),
                        ],
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    )
  );
  
  @override
  void datanya(theData) {
    lsData.assignAll(
      theData == null? RestRestponseRestaurant.reportOverviewAndBestDay.map((e) => ModelReportOverviewAndBestDay.fromJson(e)).toList():
      (theData as List).map((e) => ModelReportOverviewAndBestDay.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.reportOverviewAndBestDay();

  @override
  String get title => "Report Overview And Best Day";

}
