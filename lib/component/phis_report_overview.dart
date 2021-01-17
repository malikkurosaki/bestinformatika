import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_report_overview.dart';
class PhisReportOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX(
        initState: (x)  =>  ControllerReportOverview.to.init(),
        builder: (_) => !ControllerReportOverview.to.loading.value? detailReport(): Row(
        children: [
          for(var i = 0; i < 4; i++)
          Expanded(
            child: Card(
              color: Colors.cyan[100],
              child: Container(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator()
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget detailReport(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text("Report Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ],
            )
          ),
          //Text(ControllerReportOverview.to.reportOverview.toString()),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  for(var i = 0; i < ControllerReportOverview.to.reportOverview.length; i++)
                  Expanded(
                    child: Card(
                      color: Colors.grey[100],
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.cyan[700],
                              padding: EdgeInsets.all(8),
                              child: Text(ControllerReportOverview.to.reportOverview[i]['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              )
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: CircleAvatar(
                                backgroundColor: Colors.cyan,
                                radius: 30,
                                child: Text(ControllerReportOverview.to.reportOverview[i]['total'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.cyan[200],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.people),
                                          Text(ControllerReportOverview.to.reportOverview[i]['adult'].toString())
                                        ],
                                      ),
                                    )
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.cyan[300],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.person_outline),
                                          Text(ControllerReportOverview.to.reportOverview[i]['child'].toString())
                                        ],
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                color: Colors.cyan[800],
                                child: InkWell(
                                  onTap: () => ControllerReportOverview.to.menujuExtendReport(i),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('details',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              // FlatButton(
                              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              //   color: Colors.orange,
                              //   onPressed: () => ControllerReportOverview.to.menujuExtendReport(i), 
                              //   child: Text("detail",
                              //     style: TextStyle(
                              //       color: Colors.white
                              //     ),
                              //   )
                              // ),
                            )
                          ],
                        )
                      ),
                    ),
                  )
                ],
              ),
              ControllerReportOverview.to.tunggu.value?
              Center(child: CircularProgressIndicator(strokeWidth: 2,)):SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}