import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:probus_mobile/component/presto_home_dashboard.dart';
import 'package:probus_mobile/component/presto_payment_fb.dart';
import 'package:probus_mobile/component/presto_product_sales.dart';
import 'package:probus_mobile/component/presto_transaction_summary.dart';

class PrestoCtrl extends GetxController{
  static PrestoCtrl get to => Get.find();
  final kode_out = "all".obs;
  final group = "food".obs;
  final kode_out_text = "All".obs;
  final property_name = "".obs;
  static final tahun = DateFormat('yyyy-M-d').format(DateTime.now());
  static final tgl = tahun.split("-")[2];
  static final bln = tahun.split("-")[1];
  static final thn = tahun.split("-")[0];

  updateData()async{
    print(kode_out);
    PrestoDashboardController.mengambilDashboard(kode_out.value);
    PaymentFbCtrl.mendapatkanPaymentFb(kode_out.value);
    ProductSalesCtrl.mendapatkanProductSales(kode_out.value, group.value);
    TransactionSummaryCtrl.init(kode_out.value);
  }
}