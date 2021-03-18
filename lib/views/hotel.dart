import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/components_phis/arrival.dart';
import 'package:probus_mobile/components_phis/arrival_tomorrow.dart';
import 'package:probus_mobile/components_phis/departure.dart';
import 'package:probus_mobile/components_phis/departure_tomorrow.dart';
import 'package:probus_mobile/components_phis/forecast_occupancy.dart';
import 'package:probus_mobile/components_phis/hotel_home.dart';
import 'package:probus_mobile/components_phis/inhouse.dart';
import 'package:probus_mobile/components_phis/inhouse_tomorrow.dart';
import 'package:probus_mobile/components_phis/reservation.dart';
import 'package:probus_mobile/components_phis/room_production.dart';
import 'package:probus_mobile/components_phis/room_production_by_city.dart';
import 'package:probus_mobile/components_phis/room_production_by_country.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';
import 'package:probus_mobile/views/calendar_coba.dart';
import 'package:probus_mobile/views/calendar_v5.dart';

class Hotel extends StatelessWidget {

  static final ls = ["inhouse", "arrival", "departure", "reserveation"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                        ),
                        DebugButton()
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
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// gambar app bar
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
                        width: double.infinity,
                        height: 150,
                        child: Image.asset("assets/images/today.png",
                          color: Colors.blueGrey[900],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(8),
                        color: Colors.blue,
                        elevation: 5,
                        child: TextButton(
                          onPressed: () => Get.to(CalendarV5()), 
                          child: Row(
                            children: [
                              Image.asset("assets/images/calendar.png",
                                width: 150,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Text("Calendar Booking",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.to(CalendarCoba()), 
                        child: Text("percobaan")
                      ),

                      /// reservation
                      reservationInfo(),
                      
                      HotelHome(denganJudul: true,),
                      ForecastOcccupancy(denganJudul: true,),
                      RoomProductionByCountry(denganJudul: true,),
                      RoomProductionByCity(denganJudul: true),
                      //RoomProduction(denganJudul: true,),
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

  Widget reservationInfo() =>
  Container(
    margin: EdgeInsets.all(4),
    child: FlipCard(
      onFlip: () => Suara.soundPool.play(Suara.waterId),
      front: Card(
        elevation: 10,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text("Today",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InHouse("assets/images/inhouse.png"),
                          Arrival("assets/images/arrival.png"),
                          Departure("assets/images/departure.png"),
                          Reservation("assets/images/reservation.png"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Tomorrow",).judul,
                  Icon(Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ), 
      back: Card(
        elevation: 10,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text("Tomorrow",
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          ArrivalTomorrow("assets/images/arrival.png"),
                          DepartureTomorrow("assets/images/departure.png"),
                          InHouseTomorrow("assets/images/inhouse.png"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text("Today",).judul,
                  )
                ],
              ),
            )
          ],
        ),
      ), 
    ),
  );
}

class DebugButton extends Bantuan{

  @override
  Widget build(BuildContext context) => 
  TextButton(
    onPressed: (){
      print(Bantuan.debugMode.value);
      Bantuan.debugMode.value = !Bantuan.debugMode.value;
    }, 
    child: Text("debug")
  );

  static coba(){}

  @override
  void datanya(theData) {
  // TODO: implement datanya
  }

  @override
  Future get restApi => Future.delayed(Duration(milliseconds: 1));

  @override
  String get title => "debug";

}
