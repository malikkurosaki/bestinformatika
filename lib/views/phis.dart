import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/component/calendar_booking_v3.dart';
import 'package:probus_mobile/component/calendar_v5.dart';
import 'package:probus_mobile/component/calendar_v6.dart';
import 'package:probus_mobile/component/percobaan.dart';
import 'package:probus_mobile/component/phis_by_city.dart';
import 'package:probus_mobile/component/phis_by_country.dart';
import 'package:probus_mobile/component/phis_daily_movement.dart';
import 'package:probus_mobile/component/phis_forecast_occupancy.dart';
import 'package:probus_mobile/component/phis_occupancy.dart';
import 'package:probus_mobile/component/phis_report_overview.dart';
import 'package:probus_mobile/component/phis_reservation_overview.dart';
import 'package:probus_mobile/component/phis_top_10_room_production.dart';

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
                          Row(
                            children: [
                              // FlatButton(onPressed: () => Get.toNamed("/calendar"), 
                              // child: Text("calendar")
                              // ),
                              // FlatButton(
                              //   onPressed: () => Get.to(PercobaanCalendar()), 
                              //   child: Text("percobaan Calendar")
                              // ),
                              // FlatButton(
                              //   onPressed: () => Get.to(CalendarV3()), 
                              //   child: Text("calendar v3")
                              // ),
                              // FlatButton(
                              //   onPressed: () => Get.to(CalendarV4()),
                              //   child: Text("percobaan")
                              // ),
                              FlatButton(
                                onPressed: () => Get.to(CalendarV5()),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today
                                    ),
                                    Text("  Calendar Booking"),
                                  ],
                                )
                              ),
                              FlatButton(
                                onPressed: () => Get.to(CalendarV6()), 
                                child: Text("calendar v6")
                              )
                            ],
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
                color: Colors.white,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}