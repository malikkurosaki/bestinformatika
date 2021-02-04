import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/component/phis_calendar_booking.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/controller_by_city.dart';
import 'package:probus_mobile/controllers/controller_daily_movelemt.dart';
import 'package:probus_mobile/controllers/controller_extend_report.dart';
import 'package:probus_mobile/controllers/controller_forecast_occupancy.dart';
import 'package:probus_mobile/controllers/controller_home.dart';
import 'package:probus_mobile/controllers/controller_login.dart';
import 'package:probus_mobile/controllers/controller_occupancy.dart';
import 'package:probus_mobile/controllers/controller_phis.dart';
import 'package:probus_mobile/controllers/controller_profile.dart';
import 'package:probus_mobile/controllers/controller_report_overview.dart';
import 'package:probus_mobile/controllers/controller_reservation_overview.dart';
import 'package:probus_mobile/controllers/controller_by_country.dart';
import 'package:probus_mobile/controllers/controller_top_10_room_production.dart';
import 'package:probus_mobile/controllers/log_ctrl.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:probus_mobile/views/home.dart';
import 'package:probus_mobile/views/login.dart';
import 'package:probus_mobile/views/phis.dart';
import 'package:probus_mobile/views/presto.dart';
import 'package:probus_mobile/views/profile.dart';
import 'package:probus_mobile/views/report_overview_extend.dart';

import 'controllers/splash_screen.dart';

void main()async{
  await GetStorage.init();
  Get.put(LogCtrl());
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: GetMaterialApp(
        title: 'Probus Mobile',
        enableLog: true,
        initialRoute: '/',
        initialBinding: BindingPertama(),
        getPages: pages,
        debugShowCheckedModeBanner: false,
        unknownRoute: GetPage(name: '/404', page: () => Card(child: Center(child: Text('404'),),)),
      ),
    );
  }
}

List<GetPage> pages = <GetPage>[
  GetPage(name: '/', page: () => RootView()),
  GetPage(name: '/home', page: () => Home()),
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/splash', page: () => SplashScreen()),
  GetPage(name: '/profile', page: () => Profile()),
  GetPage(name: '/phis', page: () => Phis()),
  GetPage(name: '/presto', page: () => Presto()),
  GetPage(name: '/overview-extend', page: () => ReportOverviewExtend()),
  GetPage(name: '/calendar', page: () => PhisCalendarBooking())
];

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.cyan[900],
      body: Center(
        child: Text(
          "PROBUS \nSYSTEM",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            shadows: [
              Shadow(
                blurRadius: 2,
                offset: Offset(2, 2),
                color: Colors.black
              )
            ]
          ),
        ),
      ),
    );
  }
}

class BindingPertama extends Bindings{
  @override
  void dependencies() async {
    try {
      Get.put<ControllerSplash>(ControllerSplash());
      Get.put<ControllerLogin>(ControllerLogin());
      Get.put<ControllerProfile>(ControllerProfile());
      Get.put<ControllerHome>( ControllerHome() );
      Get.put<ControllerPhis>(ControllerPhis());
      Get.put<ControllerOccupancy>(ControllerOccupancy());
      Get.put<ControllerApi>(ControllerApi());
      Get.put<ControllerReportOverview>(ControllerReportOverview());
      Get.put<ControllerDailyMovement>(ControllerDailyMovement());
      Get.put<ControllerReservationOverview>(ControllerReservationOverview());
      Get.put<ControllerTop10RoomProduction>(ControllerTop10RoomProduction());
      Get.put<ControllerByCountry>(ControllerByCountry());
      Get.put<ControllerByCity>(ControllerByCity());
      Get.put<ControllerForecastOccupancy>(ControllerForecastOccupancy());
      Get.put<ControllerExtenReportOverview>(ControllerExtenReportOverview());
      Get.put(PrestoCtrl());
      Get.put(PhisCtrl());
    } catch (e) {
      console.log(e);
    }
  }

}

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX(
        initState: (_) => ControllerSplash.to.mulaiSplash(),
        builder: (controller) => !ControllerSplash.to.splash.value?SplashScreen():Card(child: Center(child: Text("Probus \nSystem"),),)
      )
    );
  }
}

