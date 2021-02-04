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
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text("Report Overview",
                  style: TextStyle(
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
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.cyan[900],
                            padding: EdgeInsets.all(4),
                            child: Text(ControllerReportOverview.to.reportOverview[i]['name'],
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              radius: 30,
                              child: Text(ControllerReportOverview.to.reportOverview[i]['total'].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            padding: EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.people,
                                          size: 18,
                                        ),
                                        Text(ControllerReportOverview.to.reportOverview[i]['adult'].toString())
                                      ],
                                    ),
                                  )
                                ),
                                Expanded(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.person_outline,
                                          size: 18,
                                        ),
                                        Text(ControllerReportOverview.to.reportOverview[i]['child'].toString())
                                      ],
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            color: Colors.cyan[900],
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () => ControllerReportOverview.to.menujuExtendReport(i),
                              child: Container(
                                child: Text('details',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.orange[200],
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