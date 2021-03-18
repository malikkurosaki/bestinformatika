import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/components_presto/daily_revenue.dart';
import 'package:probus_mobile/components_presto/home_index.dart';
import 'package:probus_mobile/components_presto/master/master_date.dart';
import 'package:probus_mobile/components_presto/master/master_outlet.dart';
import 'package:probus_mobile/components_presto/master/master_tipe.dart';
import 'package:probus_mobile/components_presto/master/mater_group_product.dart';
import 'package:probus_mobile/components_presto/payment_fb.dart';
import 'package:probus_mobile/components_presto/product_sales.dart';
import 'package:probus_mobile/components_presto/report_overview_and_best_day.dart';
import 'package:probus_mobile/components_presto/sales_analisys_avarage_perpax.dart';
import 'package:probus_mobile/components_presto/sales_analisys_by_time_order.dart';
import 'package:probus_mobile/components_presto/sales_performance.dart';
import 'package:probus_mobile/components_presto/sales_trafic.dart';
import 'package:probus_mobile/components_presto/transaction_summary.dart';
import 'package:probus_mobile/models_presto/model_home_index.dart';
import 'package:get/get.dart';

class Restaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              color: Colors.blue,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Hero(
                          tag: GetStorage().read("hero"),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 24,
                            backgroundImage: NetworkImage(GetStorage().read("hero_image"),),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(GetStorage().read("hero_name"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w100,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue,
                                Colors.white
                              ]
                            )
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16),
                          height: 150,
                          child: Image.asset('assets/images/restaurant2.png',
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                          color: Colors.grey[100],
                          alignment: Alignment.center,
                          child: MasterOutlet((){
                          // ReportOverviewAndBestDayCtrl.init();
                              PrestoHomeIndex().init();
                              PaymentFb().init();
                              ProductSales().init();
                              SalesPerformance().init();
                              SalesTrafic().init();
                              DailyRevenue().init();
                              SalesAnalisysAvaragePerPax().init();
                              SalesAnalisysByTimeOrder().init();
                              ReportOverviewAndBestDay().init();
                              TransactionSummary().init();
                          }),
                        ),
                     
                      // MasterGroupProduct((hasil) => Text(hasil.toString())),
                      // MasterDate((tanggal) => print(tanggal)),
                      // MasterTipe(
                      //   lsTipe: ["DTD", "MTD", "YTD"],
                      //   hasil: (hasil) => print(hasil),
                      // ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: PrestoHomeIndex(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: PaymentFb(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: ProductSales(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SalesPerformance(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SalesTrafic(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: DailyRevenue(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SalesAnalisysAvaragePerPax(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SalesAnalisysByTimeOrder(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: ReportOverviewAndBestDay(denganJudul: true,)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: TransactionSummary(denganJudul: true,)
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}