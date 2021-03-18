import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/views/login.dart';
import 'package:get/get.dart';
import 'models_phis/model_hotel_home.dart';
import 'store.dart';
import 'tema.dart';


typedef HasilData<T> = Widget Function(T);
typedef HasilPilihan<T> = Function(T);
typedef OnDipilih = Function();

abstract class TemplateData<T> extends StatelessWidget{
  final RxList<T> lsData = <T>[].obs;
  final OnDipilih onDipilih;
  final loadingText = "loading ...".obs;
  final judul;
  TemplateData({Key key, this.onDipilih, this.judul}) : super(key: key);
  
  Widget olah(HasilData<RxList<T>> hasilData) =>
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    judul != null?Text(judul).boldUpper: 
    SizedBox.shrink(),
    FutureBuilder(
      future: getData(),
      builder: (context, snapshot) => 
      snapshot.connectionState != ConnectionState.done?
      Text("${loadingText.value} ${judul??''} ...").biasa: hasilData(lsData)
    ),
  ],
  );
  
  Future getData();
  
}

abstract class TemplateDataHome<T> extends StatelessWidget{
  final Rx mapData = ModelHotelHome().obs;
  final loadingText = "loading ...".obs;
  Widget olah(HasilData<Rx<T>> hasilData) =>
  Container(
    child: FutureBuilder(
      future: getData(),
      builder: (context, snapshot) => 
      snapshot.connectionState != ConnectionState.done?
      Text(loadingText.value): mapData == null?
      Text("data is empty"):
      hasilData(mapData)
    ),
  );
  Future getData();
}

class RestApi extends GetConnect{
  static final host = "https://report-mobile.probussystem.com";
  
  /// phis
  /// ==========================
  Future login(Map auth) async {
    try {
      Response res = await post('$host/api/login', auth);
      if(res.body['status']){
        await GetStorage().write("token", res.body['data']['token']);
        await GetStorage().write("userData", res.body['data']);
        Get.offNamed('/home');
      }else{
        Get.dialog(SimpleDialog(
          title: Text("auth"),
          children: [
            Text("Email and password do not match")
          ],
        ));
      }
    } catch (e) {
      print(e.toString());
      Get.dialog(SimpleDialog(
        title: Text("auth"),
        children: [
          Text(e.toString())
        ],
      ));
    }
  }

  static home() async => await RestApi().get('$host/api/home?outlet='+Store.outletId, headers: Store.headers);
  
  static inHouse() async => await RestApi().get('$host/api/inHouse?outlet='+Store.outletId, headers: Store.headers);
  static arrival() async => await RestApi().get('$host/api/arrival?outlet='+Store.outletId, headers: Store.headers);
  static departure() async => await RestApi().get('$host/api/departure?outlet='+Store.outletId, headers: Store.headers);
  static reservation() async => await RestApi().get('$host/api/reservation?outlet='+Store.outletId, headers: Store.headers);

  static roomProduction() async => await RestApi().get('$host/api/roomProduction?outlet='+Store.outletId, headers: Store.headers);

  static arrivalTomorrow() async => await RestApi().get('$host/api/arrivalTomorrow?outlet='+Store.outletId, headers: Store.headers);
  static departureTomorrow() async => await RestApi().get('$host/api/departureTomorrow?outlet='+Store.outletId, headers: Store.headers);
  static inhouseTomorrow() async => await RestApi().get('$host/api/inhouseTomorrow?outlet='+Store.outletId, headers: Store.headers);

  static forecastOcc() async => await RestApi().get('$host/api/forecastOcc?outlet='+Store.outletId, headers: Store.headers);
  static roomProductionByCountry() async => await RestApi().get('$host/api/roomProductionByCountry?outlet='+Store.outletId, headers: Store.headers);
  static roomProductionByCity() async => await RestApi().get('$host/api/roomProductionByCity?outlet='+Store.outletId, headers: Store.headers);
  static performainvoice() async => await RestApi().get('$host/api/performainvoice?nores=${Store.noRes}&outlet='+Store.outletId, headers: Store.headers);
  


  /// presto
  /// ==============================
  /// [kode_out] ambil dari master outlet default all
  /// [group] ambil dari master group
  /// [outlet] adalah kode outlet
  /// [dept] ambil dari master dept => default [kosong / all]
  /// [date] format Y-M-D / default [kosong / all ] 
  /// jenis [tipe]
  ///   - DTD, MTD, YTD
  ///   - DTD, YTD
  ///   - DTD, MTD
  
  static Future<Response> masterOutlet() async => await RestApi().get('$host/api/getOutletsPresto?outlet='+Store.outletId, headers: Store.headers);
  static masterGroupProduct() async => await RestApi().get('$host/api/getMasterGroup?outlet='+Store.outletId, headers: Store.headers);
  
  /// [kode_out] tambahan [date], [dept], [outlet]
  /// [date] dan [dept] bis kosong
  static homeindex() async => await RestApi().get('$host/api/homeFb/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);
  
   /// tambahan [date] dan [dept]
  static paymentFb() async => await RestApi().get('$host/api/paymentFb/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);
  
   /// tambahan [date] dan [dept] dan [tipe]
   /// master [type] DTD, MTD, YTD
  static productSales() async => await RestApi().get('$host/api/productSales/${Store.group}/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&tipe=${Store.tipe}&outlet='+Store.outletId, headers: Store.headers);
  
   /// tambahan [date] dan [dept]
  static transactionSummary() async => await RestApi().get('$host/api/transactionSummary/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);
  
   /// tambahan [date] dan [dept]
  static salesPerformance() async => await RestApi().get('$host/api/salesPerformance/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);
  
   /// tambahan [date] dan [dept]
  static salesTrafic() async => await RestApi().get('$host/api/salesTrafic/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);

  // /// tambahan [date]
  // static sales(String date) async => await RestApi().get('$host/api/salesReport?date=$date&outlet='+Store.outletId, headers: Store.headers);
  
  // /// tambahan [date]
  // static netgross(String date) async => await RestApi().get('$host/api/netGrossReport?date=$date&outlet='+Store.outletId, headers: Store.headers);
  
  /// tambahan [date] dan [dept]
  static dailyRevenue() async => await RestApi().get('$host/api/dailyRevenueReport/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);
  
  /// tambahan [date] dan [tipe] dan [dept] 
  /// master [tipe] DTD, YTD
  static salesAnalysisByAvarageBillPax() async => await RestApi().get('$host/api/salesAnalisisAverage/${Store.kodeOut}?date=${Store.date}&tipe=${Store.tipe}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);
  
  /// tambahan [date] dan [tipe] dan [dept]
  /// master [tipe] DTD, MTD
  static salesAnalysisTime() async => await RestApi().get('$host/api/salesAnalisisTime/${Store.kodeOut}?date=${Store.date}&tipe=${Store.tipe}&dept=${Store.dept}&outlet='+Store.outletId, headers: Store.headers);

  /// tambahan [date] dan [dept]
  static reportOverviewAndBestDay() async => await RestApi().get('$host/api/dailyRevenueReport/${Store.kodeOut}?date=${Store.date}&dept=${Store.dept}t&outlet='+Store.outletId, headers: Store.headers);



  /// calendar booking
  /// ================
  static roomType() async => await RestApi().get('$host/api/roomType?outlet='+Store.outletId, headers: Store.headers);
  static room() async => await RestApi().get('$host/api/room?outlet='+Store.outletId, headers: Store.headers);
  static roomAvailable() async => await RestApi().get('$host/api/roomAvailable?outlet='+Store.outletId, headers: Store.headers);
  
  // , String roomType, String roomFilter
  static listBooking(String start, String end) async => await RestApi().get('$host/api/listBooking?start=$start&end=$end&roomType=&roomFilter=&outlet='+Store.outletId, headers: Store.headers);
  static listBookingReservation(String no_res) async => await RestApi().get('$host/api/roomAvailable?no_res=$no_res&outlet='+Store.outletId, headers: Store.headers);

  static cekData(Response response) {
    print(response.isOk);
    
    // return response.body == null ? null: 
    // !(response.body is Map) ? null:
    // response.body['data'] == null? null: 
    // response.body['data']['data'] == null? null: 
    // response.body['data']['data'].length == 0? null: 
    // response.body['data']['data'];

    return null;
  }
  

}

