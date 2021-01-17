
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';

class ControllerApi extends GetConnect{
  static ControllerApi get to => Get.find();
  
  final host = "https://report-mobile.probussystem.com";
  //static final String token = GetStorage().hasData('token')?GetStorage().read("token"):0;
  //final int id =  GetStorage().hasData('outlet')?int.parse(GetStorage().read('outlet')['id'].toString()):0;
  //final Map headers = GetStorage().hasData('token')?{"Authorization": "Bearer "+GetStorage().read("token")}:{"Authorization": "Bearer "};
  
  Future login(Map auth) async => await post('$host/api/login', auth);

  // occcupancy
  Future<Response> home() async => await get('$host/api/home?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});

  // report overview
  Future inhouse() async => get('$host/api/inHouse?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future arrival() async => get('$host/api/arrival?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future departure() async => get('$host/api/departure?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future reservetion() async => get('$host/api/reservation?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});

  Future roomProduction() async => get('$host/api/roomProduction?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});

  Future arrivalTomorrow() async => get('$host/api/arrivalTomorrow?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future departureTomorrow() async => get('$host/api/departureTomorrow?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future inhouseTomorrow() async => get('$host/api/inhouseTomorrow?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});

  Future foreCastOcupancy() async => await get('$host/api/forecastOcc?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future roomProductionByCountry() async => await get('$host/api/roomProductionByCountry?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future roomProductionByCity() async => await get('$host/api/roomProductionByCity?outlet='+GetStorage().read('id').toString(), headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future performaInvoice(String nores) async => await get('$host/api/performainvoice?outlet=${GetStorage().read('id').toString()}&nores=$nores',headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  

  // presto
  Future masterOutlet() async => get("$host/api/getOutletsPresto?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future masterGroupProduct() async => get("$host/api/getMasterGroup?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoHomeindex(String kode_out) async => get("$host/api/homeFb/$kode_out?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoPaymentFb(String kode_out) async => get("$host/api/paymentFb/$kode_out?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoProductSales(String kode_out, String group) async => get("$host/api/productSales/$group/$kode_out?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoTransactionSummary(String kode_out) async => get("$host/api/transactionSummary/$kode_out?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoSalesPerformance(String kode_out) async => get("$host/api/salesPerformance/$kode_out?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoSalesTrafic(String kode_out) async => get("$host/api/salesTrafic/$kode_out?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  
  // ini beda
  Future prestoSalesReport(String date) async => get("$host/api/salesReport?outlet=${GetStorage().read('id').toString()}&date=$date",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoNetgross(String date) async => get("$host/api/netGrossReport?outlet=${GetStorage().read('id').toString()}&date=$date",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoDailyRevenue(String date) async => get("$host/api/dailyRevenueReport?outlet=${GetStorage().read('id').toString()}&date=$date",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  Future prestoProductSalesReport(String date, String type) async => get("$host/api/productSalesReport?outlet=${GetStorage().read('id').toString()}&date=&type=$type",headers: {"Authorization": "Bearer "+GetStorage().read("token")});

  // calendar booking /listBooking?start=&end=&roomType=&roomFilter=
  Future calendarBooking() async => get("$host/api/listBooking?start=&end=&roomType=&roomFilter=",headers: {"Authorization": "Bearer "+GetStorage().read("token")});
  // room type  => /api/roomType?outlet=
  Future calendarRoomType() async => get("$host/api/roomType?outlet=${GetStorage().read('id').toString()}",headers: {"Authorization": "Bearer "+GetStorage().read("token")});

}