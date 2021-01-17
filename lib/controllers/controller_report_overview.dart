import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_api.dart';



class ControllerReportOverview extends GetxController{
  static ControllerReportOverview get to => Get.find();
  final loading = false.obs;
  final reportOverview = [].obs;
  final tunggu = false.obs;

  init() async {
    this.loading.value = true;
    this.tunggu.value = true;
    if(GetStorage().hasData('paket_report_overview')){
      this.loading.value = false;
      this.reportOverview.assignAll(GetStorage().read('paket_report_overview'));
    }

    //print("adalah"+GetStorage().read('id').toString());
    Response inh = await ControllerApi.to.inhouse();
    print(inh.body);
    final inHouse = inh.body['data']['data']??[];

    

    Response arr = await ControllerApi.to.arrival();
    List arrival = arr.body['data']['data']??[];

    Response dpr = await ControllerApi.to.departure();
    List departure = dpr.body['data']['data']??[];

    Response rsv = await ControllerApi.to.reservetion();
    List reservation = rsv.body['data']['data']??[];


    // tomorrow
    Response inhT = await ControllerApi.to.inhouseTomorrow();
    final inHouseT = inh.body['data']['data']??[];

     Response arrT = await ControllerApi.to.arrivalTomorrow();
    List arrivalT = arr.body['data']['data']??[];

    Response dprT = await ControllerApi.to.departureTomorrow();
    List departureT = dpr.body['data']['data']??[];

    // Response rsvT = await ControllerApi.to.reservetion();
    // List reservationT = rsv.body['data']['data'];

    // simpan dulu yang today
    await GetStorage().write(TODAY.Inhouse.toString(), inHouse);
    await GetStorage().write(TODAY.Arrival.toString(), arrival);
    await GetStorage().write(TODAY.Departure.toString(), departure);
    await GetStorage().write(TODAY.Reservation.toString(), reservation);

    // simpan dulu yang tomorrow
    await GetStorage().write(TOMORROW.Inhouse.toString(), inHouseT);
    await GetStorage().write(TOMORROW.Arrival.toString(), arrivalT);
    await GetStorage().write(TOMORROW.Departure.toString(), departureT);
    //await GetStorage().write(TODAY.Reservation.toString(), reservation);


    final inhouseAdult = inHouse.isEmpty?0:inHouse.map((e) => e['pax']).toList().reduce((value, element) => value??0 + element??0);
    final inhouseChild = inHouse.isEmpty?0: inHouse.map((e) => e['pax2']).toList().reduce((value, element) => value??0 + element??0);

    final arrivalAdult = arrival.isEmpty?0: arrival.map((e) => e['pax']).toList().reduce((value, element) => value??0 + element??0);
    final arrivalChild = arrival.isEmpty?0: arrival.map((e) => e['pax2']).toList().reduce((value, element) => value??0 + element??0);

    final departureAdult = departure.isEmpty?0:departure.map((e) => e['pax']).toList().reduce((value, element) => value??0 + element??0);
    final departureChild = departure.isEmpty?0:departure.map((e) => e['pax2']).toList().reduce((value, element) => value??0 + element??0);

    final reservationAdult = reservation.isEmpty?0:reservation.map((e) => e['pax']).toList().reduce((value, element) => value??0 + element??0);
    final reservationChild = reservation.isEmpty?0:reservation.map((e) => e['pax2']).toList().reduce((value, element) => value??0 + element??0);

    final paket = [
      {
        "name": "Inhouse",
        "data": inHouse,
        "dataT": inHouseT,
        "adult": inhouseAdult,
        "child": inhouseChild,
        "total": inHouse.length
      },
      {
        "name": "Arrival",
        "data": arrival,
        "dataT": arrivalT,
        "adult": arrivalAdult,
        "child": arrivalChild,
        "total": arrival.length
      },
      {
        "name": "Departure",
        "data": departure,
        "dataT": departureT,
        "adult": departureAdult,
        "child": departureChild,
        "total": departure.length
      },
      {
        "name": "Reservation",
        "data": reservation,
        "dataT": [],
        "adult": reservationAdult,
        "child": reservationChild,
        "total": reservation.length
      }
    ];

    // print(JsonEncoder.withIndent(" ").convert(paket));

    await GetStorage().write('paket_report_overview', paket);

    this.reportOverview.assignAll(paket);
    this.loading.value = false;
    this.tunggu.value = false;

  }

  menujuExtendReport(int i)async{
    await GetStorage().write("report_data", this.reportOverview[i]);
    // print(this.reportOverview[i]);
    Get.toNamed('/overview-extend');
  }
}

enum TODAY {
  Inhouse,
  Arrival,
  Departure,
  Reservation
}

enum TOMORROW {
  Inhouse,
  Arrival,
  Departure,
  Reservation
}