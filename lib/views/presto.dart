import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/component/presto_appbar.dart';
import 'package:probus_mobile/component/presto_home_dashboard.dart';
import 'package:probus_mobile/component/presto_net_gros_report.dart';
import 'package:probus_mobile/component/presto_payment_fb.dart';
import 'package:probus_mobile/component/presto_product_sales.dart';
import 'package:probus_mobile/component/presto_sales-performance.dart';
import 'package:probus_mobile/component/presto_sales_performance_report.dart';
import 'package:probus_mobile/component/presto_transaction_summary.dart';
import 'package:probus_mobile/component/preto_sales_trafic.dart';

class Presto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrestoAppbar(),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PrestoHomeDashboard(),
                    PrestoPaymentFb(),
                    PrestoProductSales(),
                    PrestoTransactionSummary(),
                    PrestoSalesPerformance(),
                    PrestoSalaesTrafic(),
                    PrestoSalesPerformanceReport(),
                    PrestoNetgrossReport(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}