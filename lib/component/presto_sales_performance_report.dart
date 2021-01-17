import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoSalesPerformanceReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("sales Performance report",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey
                ),
              ),
            ),
            GetX(
              initState: (state) => PerformanceReportCtrl.init(DateTime.now().toIso8601String().split("T")[0]),
              builder: (controller) => PerformanceReportCtrl.loading5.value?Center(child: CircularProgressIndicator(),):
              PerformanceReportCtrl.lsReport.isEmpty?Center(child: Text("No Data Available"),):
              GridView.count(crossAxisCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  for(var i = 0; i < PerformanceReportCtrl.lsReport.length; i++)
                  Card(
                    color: PerformanceReportCtrl.lsReport[i]['month'] == PrestoCtrl.bln?Colors.blueGrey[300]:Colors.blueGrey[100],
                    child: Column(
                      children: [
                        Card(
                          color: Colors.blueGrey,
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(PerformanceReportCtrl.bulan[int.parse(PerformanceReportCtrl.lsReport[i]['month'].toString()) -1 ].toString().toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              )
                            )
                          )
                        ),
                        Flexible(
                          child: Center(
                            child: Text(PerformanceReportCtrl.lsReport[i]['value'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey
                              ),
                            )
                          )
                        ),
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

class PerformanceReportCtrl extends PrestoCtrl{
  static final loading5 = false.obs;
  static final lsReport = [].obs;
  static final bulan = [
    "jan",
    "feb",
    "mart",
    "aprl",
    "may",
    "jun",
    "jul",
    "ags",
    "sep",
    "okt",
    "nov",
    "des"
  ];

  static init(String date)async{
    loading5.value = true;
    try {
      if(GetStorage().hasData("report")){
        lsReport.assignAll(GetStorage().read("report"));
        loading5.value = false;
      }

      Response res = await ControllerApi.to.prestoSalesReport(date);
      final data = res.body['data']['data']??[];
      lsReport.assignAll(data);
      await GetStorage().write("report", data);
      //lsReport.assignAll(fake['data']['data']);
    } catch (e) {
      print(e);
    }
    loading5.value = false;
  }

  static final Map fake = {
    "response": 200,
    "message": "Sales Report",
    "status": true,
    "param": {
      "outlet": "1",
      "date": null
    },
    "data": {
      "data": [
        {
          "month": "1",
          "value": "456088594"
        },
        {
          "month": "2",
          "value": "430187315"
        },
        {
          "month": "3",
          "value": "333074509"
        },
        {
          "month": "4",
          "value": "202797808"
        },
        {
          "month": "5",
          "value": "181896689"
        },
        {
          "month": "6",
          "value": "177557290"
        },
        {
          "month": "7",
          "value": "171962375"
        },
        {
          "month": "8",
          "value": "168971487"
        },
        {
          "month": "9",
          "value": "161668172"
        },
        {
          "month": "10",
          "value": "158386072"
        },
        {
          "month": "11",
          "value": "161994702"
        },
        {
          "month": "12",
          "value": "4787128"
        }
      ]
    }
  };
}