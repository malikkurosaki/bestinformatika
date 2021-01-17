import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probus_mobile/component/phis_by_city.dart';
import 'package:probus_mobile/component/phis_by_country.dart';
import 'package:probus_mobile/component/phis_forecast_occupancy.dart';
import 'package:probus_mobile/component/phis_top_10_room_production.dart';
import 'package:probus_mobile/component/phis_daily_movement.dart';
import 'package:probus_mobile/component/phis_occupancy.dart';
import 'package:probus_mobile/component/phis_report_overview.dart';
import 'package:probus_mobile/component/phis_reservation_overview.dart';
import 'package:probus_mobile/controllers/controller_phis.dart';
import 'package:get/get.dart';

class Phis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  PhisOccupancy(),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FlatButton(onPressed: () => Get.toNamed("/calendar"), 
                          child: Text("calendar")
                          ),
                          PhisReportOverview(),
                          PhisReservationOverview(),
                          PhisDailymovement(),
                          PhisTop10RoomProduction(),
                          PhisByCountry(),
                          PhisByCity(),
                          PhisForecastOccupancy()
                        ],
                      ),
                    )
                  ),
                ],
              ),
               BackButton(
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}