import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class CalendarV3 extends StatelessWidget {
  final lebarSamping = 70.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: GetX(
            initState: (state) => CldrV3.init(),
            builder: (controller) => CldrV3.loading.value? 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Center(
                  child: Text("tunggu"),
                )
              ],
            ): 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackButton(),
                    Text("${CldrV3.calendar['tahun'].toString()} - ${CldrV3.calendar['bulan'].toString()}",
                      style: TextStyle(
                        fontSize: 24
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: lebarSamping,
                      padding: EdgeInsets.all(8),
                    ),
                    Expanded(
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        crossAxisCount: 7,
                        children: [
                          for(var hari in CldrV3.hari)
                           Center(
                            child: Text(hari.toString().substring(0, 3),
                              style: TextStyle(
                                color: hari == CldrV3.hari[0]?Colors.red: Colors.black
                              ),
                            )
                          )
                        ]
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: PageView(
                    physics: ScrollPhysics(),
                    children: List.generate(CldrV3.calendar['pekan'].length, (i1) => 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: lebarSamping,
                                padding: EdgeInsets.all(8),
                              ),
                              Expanded(
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  crossAxisCount: 7,
                                  children: [
                                    for(var pekan in CldrV3.calendar['pekan'][i1])
                                    Center(
                                      child: Text(pekan['tanggal'].toString(),
                                        style: TextStyle(
                                          color: pekan['type'] == 1?Colors.black: Colors.grey[300]
                                        ),
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: ListView(
                              controller: CldrV3.scrl,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: [
                                for(var lsRoomType in CldrV3.lsRoomType)
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  color: Colors.grey[200],
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: Text(lsRoomType['nm_jenis'].toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          for(var rooms in lsRoomType['rooms'])
                                          Row(
                                            children: [
                                              Container(
                                                width: lebarSamping,
                                                child: Center(
                                                  child: Text(rooms['no_room'].toString())
                                                )
                                              ),
                                              Expanded(
                                                child: GridView.count(
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  crossAxisCount: 7,
                                                  children: [
                                                    for(var pekan in CldrV3.calendar['pekan'][i1])
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey[300])
                                                          ),
                                                        ),
                                                        Column(
                                                          children: [
                                                            for(var events in pekan['events'].where((e) => e.length != 0 && e['roomId'] == rooms['no_room']))
                                                            Expanded(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Get.bottomSheet(
                                                                    DraggableScrollableSheet(
                                                                      builder: (context, scrollController) => 
                                                                      Card(
                                                                        child: ListView(
                                                                          controller: scrollController,
                                                                          children: [
                                                                            Text("apa ini")
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  );
                                                                },
                                                                child: Container(
                                                                  width: double.infinity,
                                                                  decoration: BoxDecoration(
                                                                    color: Color(events['backgroundColor']),
                                                                    border: Border(
                                                                      bottom: BorderSide(
                                                                        width: 4,
                                                                        color: Colors.black26,
                                                                      ),
                                                                      right: BorderSide(
                                                                        color: Colors.black26,
                                                                        width: events['jenis'] == 2?2:0
                                                                      ),
                                                                      top: BorderSide(
                                                                        color: Colors.white54,
                                                                        width: 2
                                                                      ),
                                                                    )
                                                                  ),
                                                                  child: events['jenis'] == 0?
                                                                  Center(
                                                                    child: Text(events['guestName'].toString(),
                                                                      overflow: TextOverflow.clip,
                                                                      style: TextStyle(
                                                                        fontSize: 12
                                                                      ),
                                                                    )
                                                                  ):
                                                                  Icon(Icons.arrow_forward_ios,
                                                                    color: Colors.black26,
                                                                  )
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ]
                                                  // [
                                                    // for(var pekan in CldrV3.calendar['pekan'])
                                                    // Stack(
                                                    //   children: [
                                                    //     Container(
                                                    //       decoration: BoxDecoration(
                                                    //         border: Border.all(color: Colors.grey[300])
                                                    //       ),
                                                    //     ),
                                                    //     Column(
                                                    //       children: 
                                                    //       [
                                                    //         for(var evn in pekan)
                                                    //         for(var event in evn['events'].where((e) => e['roomId'] != null).toList())
                                                    //         Text("apa")
                                                    //         //evn.where((z) => z['roomId'] == rooms['no_room']).toList()
                                                    //         // for(var event in pekan.where((e) => e['events'].length >= 1).toList())
                                                    //         // Text(event['roomId'].toString())
                                                    //         // Expanded(
                                                    //         //   child: InkWell(
                                                    //         //     onTap: () {
                                                    //         //       Get.isBottomSheetOpen?
                                                    //         //       Get.back():
                                                    //         //       Get.bottomSheet(r
                                                    //         //         DraggableScrollableSheet(
                                                    //         //           builder: (context, scrollController) => 
                                                    //         //           Card(
                                                    //         //             child: ListView(
                                                    //         //               controller: scrollController,
                                                    //         //               children: [
                                                    //         //                 for(var a in event)
                                                    //         //                 Text(
                                                    //         //                   a.toString()
                                                    //         //                 ),
                                                    //         //               ],
                                                    //         //             ),
                                                    //         //           ),
                                                    //         //         )
                                                    //         //       );
                                                    //         //     },
                                                    //         //     child: Container(
                                                    //         //       width: double.infinity,
                                                    //         //       color: Color(event['backgroundColor']),
                                                    //         //       child: Center(
                                                    //         //         child: event['jenis'] == 0?
                                                    //         //         Text(event['guestName'],
                                                    //         //           overflow: TextOverflow.clip,
                                                    //         //           textAlign: TextAlign.center,
                                                    //         //           style: TextStyle(
                                                    //         //             color: Colors.black54,
                                                    //         //             fontSize: 12
                                                    //         //           ),
                                                    //         //         ): Icon(Icons.arrow_forward_ios_rounded,
                                                    //         //           color: Colors.black26,
                                                    //         //         ),
                                                    //         //       )
                                                    //         //     ),
                                                    //         //   )
                                                    //         // )
                                                    //       ]
                                                    //     ),
                                                    //   ],
                                                    // )
                                                  // ]
                                                )
                                              )
                                            ],
                                          )
                                        ]
                                      )
                                    ],
                                  ),
                                )
                              ]
                            )
                          )
                        ],
                      )
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CldrV3 extends PhisCtrl{
  static final lsRoomType = [].obs;
  static final lsBooking = [].obs;
  static final loading = false.obs;
  static final calendar = {}.obs;
  static final scrl = TrackingScrollController();
  static final hari = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

  static init()async{
    loading.value = true;
    await initRoomType();
    await initBooking();
    await calendarSebulan(DateTime.parse("2021-01-01"));
    loading.value = false;
  }

  static munculkanApi(var data){
    Get.dialog(
      SingleChildScrollView(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Text(JsonEncoder.withIndent("   ").convert(data).toString()),
            ],
          ),
        ),
      )
    );
  }

  static initRoomType()async{
    try {
      final res = await ControllerApi.to.calendarRoomType();
      final data = res.body['data']['data'];
      final compres = data.map( (e) => {
        "kd_jenis": e['kd_jenis'],
        "nm_jenis": e['nm_jenis'],
        "rooms": List.generate(e['rooms'].length, (i) => {
          "no_room": e['rooms'][i]['no_room'],
          "nama_room": e['rooms'][i]['nama_room']
        })
      }).toList();
      lsRoomType.assignAll(compres);
    } catch (e) {
      print(e);
    }
  }

  static initBooking()async{
    try {
      final res = await ControllerApi.to.calendarBooking("2021-01-01", "2021-01-31");
      final data = res.body['data']['data'];
      final compress = data.map( (e) => {
        "roomId": e['roomId'],
        "room_name": e['room_name'],
        "guestName": e['guestName'],
        "checkIn": e['checkIn'],
        "checkOut": e['checkOut'],
        "backgroundColor": int.parse(e['backgroundColor'].toString().replaceAll("#", "0xff")),
        "range": rangeTanggal(e['checkIn'], e['checkOut'])
      }).toList();
    lsBooking.assignAll(compress);
    // munculkanApi(data.length);
    } catch (e) {
      print(e.toString());
    }
  }

  static List rangeTanggal(String checkIn, String checout) => List.generate(DateTime.parse(checout).difference(DateTime.parse(checkIn)).inDays + 1, (index) => {
    "tanggal": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).day,
    "bulan": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).month,
    "tahun": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).year,
    "jenis": DateTime.parse(checkIn).day == DateTime.parse(checkIn).day + index? 0: DateTime.parse(checout).day != DateTime.parse(checkIn).day + index? 1: 2
  }).toList();

  static calendarSebulan(DateTime kal)async{
    //  final kal = DateTime.parse(dateTime);
    final totalHari = DateTime(kal.year, kal.month + 1, 0).day;
    final Map hasil = {};
    var date = 1;
    final ls = List.generate(((kal.weekday + totalHari) / 7).ceil(), (i1) => 
      List.generate(7, (i2) => i1 == 0 && i2 < kal.weekday? 
        { 
          "type": 0,
          "tanggal": kal.subtract(Duration(days: kal.weekday)).day +i2,
          "events": []
         }: totalHari >= date ?
        { 
          "type": 1, 
          "tanggal": date++,
          "events": lsBooking.where((e) => e['range'].any((e1) => 
              e1['tanggal'] == date - 1 &&
              e1['bulan'] == kal.month &&
              e1['tahun'] == kal.year
            )
          ).toList().map((e2) => {
            "roomId": e2['roomId'],
            "room_name": e2['room_name'],
            "guestName": e2['guestName'],
            "checkIn": e2['checkIn'],
            "checkOut": e2['checkOut'],
            "backgroundColor": int.parse(e2['backgroundColor'].toString().replaceAll("#", "0xff")),
            "range": e2['range'].where((e3) => e3['tanggal'] == date -1).toList(),
            "jenis": e2['range'].where((e3) => e3['tanggal'] == date -1).toList().map((e) => e['jenis']).toList().reduce((a, b) => b)
          }).toList()
        }: 
        { 
          "type": 2, 
          "tanggal": i2++,
          "events": []
        }
      )
    );
    hasil['perBulan'] = ls.expand((element) => element).toList();
    hasil['tahun'] = kal.year;
    hasil['bulan'] = kal.month;
    hasil['tanggal'] = kal.day;
    hasil['pekan'] = ls;
    calendar.assignAll(hasil);
    
  }
}