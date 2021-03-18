import 'dart:core';
import 'dart:math';

import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pecahan_rupiah/pecahan_rupiah.dart';
import 'package:probus_mobile/models_phis/model_hotel_home.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';


class HotelHome extends Bantuan{
  static final load = false.obs;
  static final modelData = ModelHotelHome().obs;
  final denganJudul;

  HotelHome({this.denganJudul});

  @override
  Widget build(BuildContext context) => 
  buat(
    denganJudul: false,
    onFinis: () => 
    modelData.value.isBlank?
    Text("...").biasa:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// occupancy
        ocupancyContainer(modelData.value.occupancy),

        Container(
          padding: EdgeInsets.all(16),
          child: GridView.count(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            crossAxisCount: 3,
            children: [
              templateSatu(
                data: modelData.value.roomSales, 
                judul: "Room Sales"
              ),
              templateSatu(
                data: modelData.value.roomUnSold, 
                judul: "Room Unsold"
              ),
              templateSatu(
                data: modelData.value.revenue, 
                judul: "Revenue"
              ),
              templateSatu(
                data: modelData.value.roomRate, 
                judul: "Room Rate"
              ),
              templateSatu(
                data: modelData.value.lenghtOfStay, 
                judul: "Lengt Of Stay"
              ),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.only(bottom: 32),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 70,
                  ),
                  Container(
                    height: 200,
                    child: Transform.rotate(
                      angle: 0.1,
                      child: Card(
                        elevation: 5,
                        child: Image.asset("assets/images/lanscape.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sumarry Report",
                    textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 5,
                        color: Colors.blue,
                        child: guestContainer(modelData.value.guest)
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child :Card(
                        elevation: 5,
                        color: Colors.blue,
                        child: reservationSummaryContainer(modelData.value.reservationSummary)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Card(
                        elevation: 5,
                        color: Colors.blue,
                        child: inHouseSummaryContainer(modelData.value.inHouseSummary)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        roomProductionContainer(modelData.value.roomProduction),

      ],
    )
    
  );

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.home();

  @override
  datanya(dynamic theData) {
    if(theData != null) modelData.value = ModelHotelHome.fromJson(theData);
  }

  @override
  String get title => "Home";

  static final lsKlik = [false, true, false].obs;
  Widget ocupancyContainer(Occupancy occupancy) =>
  Container(
    padding: EdgeInsets.all(16),
    child: Card(
      elevation: 10,
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text("Occupancy",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    ),
                  ),
                ),
                invalidData.value? Text(" invalid data"): SizedBox.shrink()
              ],
            )
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: Center(
                        child: Text(occupancy?.yesterday?.toString()??"",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Text("Yesterday"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 150,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleWaveProgress(
                          progress: 50,
                          waveColor: Colors.blue,
                          borderColor: Colors.orange,
                          borderWidth: 5.0,
                          backgroundColor: Colors.white,
                        )
                      ),
                      Center(
                        child: Text(occupancy?.today?.toString()??"",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Today").judulPutih,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: Center(
                        child: Text(occupancy?.tomorrow?.toString()??"",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Text("Tomorrow"),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );

  Widget templateSatu({@required dynamic data, @required String judul}) =>
  FlipCard(
    onFlip: () async => await Suara.soundPool.play(Suara.soundId),
    direction: FlipDirection.VERTICAL,
    front: Card(
      elevation: 2,
      color: Colors.blue,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(judul,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            Flexible(
              child: Icon(
                Icons.show_chart_sharp,
                size: 42,
                color: Colors.orange,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(Pecahan.rupiah(value: (data?.today??0).round()),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    ), 
    back: Card(
      color: Colors.grey[200],
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Yesterday",
                  style: TextStyle(
                    fontSize: 12
                  ),
                ),
                Text(Pecahan.rupiah(value: (data?.yesterday??0).round())),
                
              ],
            ),
            Expanded(
              child: Icon(
                Icons.show_chart_sharp,
                color: Colors.black45,
                size: 42,
              ),
            ),
            Text(judul,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    ),
  );


  /// guest
  Widget guestContainer(Guest guest) => 
  ExpansionTile(
    onExpansionChanged: (value) async => Suara.soundPool.play(Suara.swipeId),
    leading: Icon(Icons.people_alt_rounded,
      color: Colors.white
    ),
    title: Text("Guest",
      style: TextStyle(
        fontSize: 18,
        color: Colors.white
      ),
    ),
    children: [
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[200],
        child: Column(
          children: [
            Text("TODAY"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(guest?.todayChild?.toString()??"",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text("Child",)
                  ],
                ),
                Column(
                  children: [
                    Text(guest?.todayAdult?.toString()??"",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text("Adult")
                  ],
                )
              ],
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[200],
        child: Column(
          children: [
            Text("YESTERDAY"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(guest?.yesterdayChild?.toString()??"",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text("Child",)
                  ],
                ),
                Column(
                  children: [
                    Text(guest?.yesterdayAdult?.toString()??"",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text("Adult")
                  ],
                )
              ],
            )
          ],
        ),
      )
    ],
  );


  Widget reservationSummaryContainer(ReservationSummary reservationSummary) => 
  ExpansionTile(
    onExpansionChanged: (value) async => Suara.soundPool.play(Suara.swipeId),
    leading: Icon(Icons.event_note_rounded,
      color: Colors.white,
    ),
    title: Text("Reservation Summary",
      style: TextStyle(
        fontSize: 18,
        color: Colors.white
      ),
    ),
    children: [
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(reservationSummary?.booking??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Booking")
              ],
            ),
            Column(
              children: [
                Text(reservationSummary?.confirmed??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Confirmed")
              ],
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(8),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(reservationSummary?.canceled??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Canseled")
              ],
            ),
            Column(
              children: [
                Text(reservationSummary?.noShow??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("No Show")
              ],
            )
          ],
        ),
      )
    ],
  );

  Widget inHouseSummaryContainer(InHouseSummary inHouseSummary) => 
  ExpansionTile(
    onExpansionChanged: (value) async => Suara.soundPool.play(Suara.swipeId),
    leading: Icon(Icons.add_chart,
      color: Colors.white
    ),
    title: Text("Inhouse Summary",
      style: TextStyle(
        fontSize: 18,
        color: Colors.white
      ),
    ),
    children: [
      Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(inHouseSummary?.compliment?.toString()??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Compliment"),
              ],
            ),
            Column(
              children: [
                Text(inHouseSummary?.compliment?.toString()??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Compliment"),
              ],
            )
          ],
        ),
      ),
      Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(inHouseSummary?.compliment?.toString()??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Compliment"),
              ],
            ),
            Column(
              children: [
                Text(inHouseSummary?.compliment?.toString()??"",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                Text("Compliment"),
              ],
            )
          ],
        ),
      )
    ],
  );

  static final toggleAnimate = false.obs;
  Widget roomProductionContainer(List<RoomProduction> roomProduction) =>
  InkWell(
    onTap: () => toggleAnimate.value = !toggleAnimate.value,
      child: Card(
      color: Colors.cyan,
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          TweenAnimationBuilder(
            tween: IntTween(begin: 1, end:  toggleAnimate.value? 100: 1),
            duration: Duration(milliseconds: 500), 
            builder: (context,int value, child) => 
            Align(
              alignment: Alignment.bottomRight,
              child: 
              Transform.rotate(
                angle: (360 / pi) * value,
                child: Icon(
                  Icons.ac_unit,
                  size:  145,
                  color: Colors.white24,
                ),
              ),
            )
          ),

          Container(
            padding: EdgeInsets.all(8),
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Room Production").judul,
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            child: Text("Kode Agent").bold
                          ),
                          Expanded(
                            child: Text("Name Agent").bold
                          ),
                          Container(
                            width: 50,
                            child: Text("Revenue").bold
                          ),
                          Container(
                            width: 50,
                            child: Text("Value",).boldEnd
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.white,
                    ),
                    for(final rm in roomProduction??[])
                    Container(
                      child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 80,
                                child: Text(rm?.kdAgen??"",
                                  overflow: TextOverflow.ellipsis,
                                )
                              ),
                              Container(
                                width: 0.5,
                                height: 20,
                                color: Colors.white,
                                child: Text(""),
                              )
                            ],
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(rm?.nmAgen?.toString()?.toLowerCase()??"",
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ),
                          Container(
                            width: 50,
                            child: Text(rm?.revenue??"")
                          ),
                          Container(
                            width: 50,
                            child: Text(rm?.value??"",
                              textAlign: TextAlign.end,
                            )
                          )
                        ],
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
          
        ],
      ),
    ),
  );

}





