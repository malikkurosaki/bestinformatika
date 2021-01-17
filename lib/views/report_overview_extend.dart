import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/component/extend_report_today.dart';
import 'package:probus_mobile/component/extend_report_tomorrow.dart';
import 'package:probus_mobile/controllers/controller_extend_report.dart';

class ReportOverviewExtend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX(
        initState: (state) => ControllerExtenReportOverview.to.init(),
        builder: (data) =>  Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Stack(
                    children: [
                      Container(
                        child: IndexedStack(
                          index: ControllerExtenReportOverview.to.index.value,
                          children: [
                            ExtendReportToday(),
                            ExtendReportTomorrow()
                          ],
                        ),
                      ),
                      BackButton()
                    ],
                  )
                ),
                Card(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => ControllerExtenReportOverview.to.lihatIndex(0),
                            child: Container(
                              color: ControllerExtenReportOverview.to.index.value == 0?Colors.cyan:Colors.white,
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Text("Today")
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => ControllerExtenReportOverview.to.lihatIndex(1),
                            child: Container(
                              color: ControllerExtenReportOverview.to.index.value == 1?Colors.cyan:Colors.white,
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Text("Tomorrow")
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}