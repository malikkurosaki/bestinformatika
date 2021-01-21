
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class PhisCalendarBooking extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        body: SafeArea(
          child: GetX(
            initState: CalendarCtrl.init(),
            builder: (controller) => CalendarCtrl.loading.value?Text("loading ..."):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan[800],
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/plan.png',)
                    )
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          BackButton(),
                          Text("Calendar Booking Report",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.yellow
                            ),
                          )
                        ],
                      ),
                      Text(CalendarCtrl.tahun.value.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(CalendarCtrl.bulanan[CalendarCtrl.bulan.value - 1].toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  color: Colors.cyan,
                  child: Row(
                    children: [
                      Card(
                        color: Colors.cyan[300],
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.calendar_view_day),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: List.generate(CalendarCtrl.hari.length, (index) => 
                            Expanded(
                              child: Center(
                                child: Text(CalendarCtrl.hari[index].toString().substring(0,3),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.cyan[800],
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: PageView.builder(
                    onPageChanged: (value) => CalendarCtrl.halaman.value = value,
                    controller: CalendarCtrl.pageController,
                    itemCount: CalendarCtrl.kalender.length,
                    itemBuilder: (context, index) => 
                    Column(
                      children: [
                        Container(
                          color: Colors.blueGrey,
                          child: Row(
                            children: [
                              /// calendar angka
                              Card(
                                color: Colors.blueGrey[300],
                                child: Container(
                                  width: 100,
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.calendar_today)
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: List.generate(CalendarCtrl.kalender[index].length, (i1) => 
                                    Expanded(
                                      child: Center(
                                        child: Text(CalendarCtrl.kalender[index][i1]['value'].toString(),
                                          style: TextStyle(
                                            color: CalendarCtrl.kalender[index][i1]['type'] == 1?Colors.white: Colors.blueGrey[400],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Listener(
                            onPointerDown: (event) => CalendarCtrl.kemana.value = 0,
                            onPointerUp: (event) => CalendarCtrl.onUp(),
                            onPointerMove: (event) {
                              if(event.delta.dx > 6) CalendarCtrl.kemana.value = 1;
                              if(event.delta.dx < -6) CalendarCtrl.kemana.value = 2;
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(CalendarCtrl.lsRoomType.length, (i2) => 
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    color: Colors.grey[200],
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              Card(
                                                color: Colors.cyan,
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Icon(Icons.roofing,
                                                      color: Colors.white,
                                                    )
                                                  )
                                                )
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: Text(CalendarCtrl.lsRoomType[i2]['nm_jenis'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: List.generate(CalendarCtrl.lsRoomType[i2]['rooms'].length, (i3) => 
                                            Row(
                                              children: [
                                                /// nomer room
                                                Card(
                                                  color: Colors.grey[300],
                                                  child: Container(
                                                    width: 100,
                                                    padding: EdgeInsets.all(8),
                                                    child: Center(
                                                      child: Text(CalendarCtrl.lsRoomType[i2]['rooms'][i3]['no_room'].toString())
                                                    )
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        children: List.generate(CalendarCtrl.kalender[index].length, (i4) => 
                                                          Expanded(
                                                            child: CalendarCtrl.lsRoomType[i2]['rooms'][i3]['no_room'].toString().toLowerCase() == CalendarCtrl.kalender[index][i4]['eventA']['room_id'].toString().toLowerCase()? 
                                                            Container(
                                                              width: double.infinity,
                                                              color: Color(int.parse(CalendarCtrl.kalender[index][i4]['eventA']['warna'].toString().replaceAll("#", "0xff"))),
                                                              child: Center(
                                                                  child: Text(CalendarCtrl.kalender[index][i4]['eventA']['guest_name'].toString(),
                                                                    overflow: TextOverflow.fade,
                                                                  ),
                                                                ),
                                                            ):
                                                            Container(
                                                              constraints: BoxConstraints(
                                                                maxHeight: 50
                                                              ),
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.grey[300]),
                                                              ),
                                                              padding: EdgeInsets.all(8),
                                                            )
                                                          )
                                                        ),
                                                      ),
                                                      /// ini diatasnya stack
                                                      Container(
                                                        child: Row(
                                                          children: List.generate(CalendarCtrl.kalender[index].length, (ia1) => 
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                      padding: EdgeInsets.all(8),
                                                                      // color: Colors.yellow,
                                                                    ),
                                                                  ),
                                                                  Expanded(                                                      
                                                                    child: Container( 
                                                                      padding: EdgeInsets.all(8),
                                                                      // color: Colors.red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                )
                                              ],
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    )
                  ),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}




class CalendarCtrl extends PhisCtrl{

  static final bulanan = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"];
  static final hari = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  static final pekanan = ["1st", "2nd", "3rd", "4th", "5th", "6ix"];
  static final loading = false.obs;
  static final pageController = PageController();
  static final kalender = [].obs;
  static final lsEvent = [].obs;
  static final lsRoomType = [].obs;

  static final tahun = DateTime.now().year.obs;
  static final bulan = DateTime.now().month.obs;
  static final halaman = 0.obs;
  static final kemana = 0.obs;
  

  static init(){
    loading.value = true;
    //kalender.assignAll(Penanggalan.sebulan(tahun.value, bulan.value)['week']);
    initAssyncCalendar();
    iniAssyncRoomType();
    initlistEvent();
    
    loading.value = false;
  }

  static initAssyncCalendar(){
    kalender.assignAll(Penanggalan.sebulan(tahun.value, bulan.value)['week']);
  }

  static iniAssyncRoomType() async {
   try {
      Response res = await ControllerApi.to.calendarRoomType();
      final data = res.body['data']['data'];
      lsRoomType.assignAll(data);
   } catch (e) {
     Get.snackbar("info", "failed get data room type");
   }
  }

  static List tanggalRange(String checkIn, String checout) => List.generate(DateTime.parse(checout).difference(DateTime.parse(checkIn)).inDays + 1, (index) => DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).day);

  static initlistEvent()async{
    Response res = await ControllerApi.to.calendarBooking();
    Get.dialog(Card(child: SingleChildScrollView(child: Text(JsonEncoder.withIndent(" ").convert(res.body).toString()),)));
    final data = res.body['data']['data'];
    /// final data = FakeApi.dataEvent['data']['data'];
    final ijc = data.map((e) => 
      {
        "check_in": e['checkIn'],
        "check_out": e['checkOut'],
        "index_awal": getPekan(e['checkIn']),
        "index_akhir": getPekan(e['checkOut']),
        "room_id": e['roomId'],
        "room_name": e['room_name'],
        "guest_name": e['guestName'],
        "pekan": getPekan(e['checkIn']),
        "index_pekan": getIndexPekan(e['checkIn'], getPekan(e['checkIn']), DateTime.parse(e['checkIn']).day),
        "tahun_awal": DateTime.parse(e['checkIn']).year,
        "tahun_akhir": DateTime.parse(e['checkOut']).year,
        "bulan_awal": DateTime.parse(e['checkIn']).month,
        "bulan_akhir": DateTime.parse(e['checkOut']).month,
        "tanggal_awal": DateTime.parse(e['checkIn']).day,
        "warna": e['backgroundColor'],
        "tanggal_akhir": DateTime.parse(e['checkOut']).day,
        "rage": tanggalRange(e['checkIn'], e['checkOut'])
      }
    ).toList();

    final tgl = Penanggalan.sebulan(tahun.value, bulan.value);

    for(var i = 0; i < ijc.length; i++){
      if(ijc[i]['tahun_awal'].toString() == tgl['tahun'].toString() && ijc[i]['bulan_awal'].toString() == tgl['bulan'].toString()){
        tgl['week'][ijc[i]['pekan']][ijc[i]['index_pekan']]['eventA'] = ijc[i];
      }
    }

    kalender.assignAll(tgl['week']);
  }

  static getPekan(String calendar) {
    final cld = DateTime.parse(calendar);
    final lsCalendar = Penanggalan.sebulan(cld.year, cld.month)['week'];
    final lsMap = lsCalendar.map((e) => e.where( (e) => e["type"] != 0 && e["type"] != 2).toList().map( (e) => e['value']).toList()).toList();
    final idx = lsMap.map( (e) => e.indexOf(cld.day)).toList().indexWhere((element) => element != -1);
    return idx;
  }

  static getIndexPekan(String calendar, int idx, int tanggal){
    final cld = DateTime.parse(calendar);
    final ls = Penanggalan.sebulan(cld.year, cld.month)['week'];
    final index = ls[idx].indexWhere((e) => e['value'] == tanggal);
    return index;
  }
  

  static onUp(){
    if(kemana.value == 1 && halaman.value == 0){
      bulan.value --;
      initAssyncCalendar();
      pageController.jumpToPage(kalender.length -1);
      if(bulan.value <= 0) {
        bulan.value = 12;
        tahun.value --;
      }
      print("kurangi");
    }

    if(kemana.value == 2 && halaman.value == (kalender.length - 1)){
      bulan.value ++;
      initAssyncCalendar();
      pageController.jumpToPage(0);
      if(bulan.value > 12) {
        bulan.value = 1;
        tahun.value ++;
        // init event
        initlistEvent();
      }
      print("bertambah");
    }

  }
}



class Penanggalan{

  static Map sebulan(int tahun, int bulan){
    final tanggal = DateTime(tahun, bulan);
    final minggu = tanggal.weekday;
    final totalHari = DateTime(tahun, bulan + 1, 0).day;

    var date = 1;
    var bulanan = {};
    bulanan['tahun'] = tahun;
    bulanan['bulan'] = bulan;
    bulanan['week'] = [];
    bulanan['day'] = [];
    for(var j = 0; j < ((minggu + totalHari) / 7).ceil(); j++) {
      bulanan['week'].add([]);
      int awal = tanggal.subtract(Duration(days: tanggal.weekday )).day;
      int akhir = 1;
      for(var i = 0; i < 7 ; i++) {
          var isi = {};
          if(j == 0 && i < minggu) {
            isi = {
              "type": 0,
              "value": awal ++,
              "eventA": {}
            };
          } 
          else if(totalHari >= date) {
              isi = {
                "type": 1,
                "value": date,
                "eventA": {}
              };
              date++;
          }
          else if(date > totalHari){
            isi = {
              "type": 0,
              "value": akhir ++,
              "eventA": {}
            };
          }
          bulanan['day'].add(isi);
          bulanan['week'][j].add(isi);
      }
    }
    return bulanan;
  }
}


// /// contoh respon api event
class FakeApi {

  static Map roomType = {
  "response": 200,
  "message": "Room Type List",
  "status": true,
  "param": {
    "outlet": "1"
  },
  "data": {
    "data": [
      {
        "kd_jenis": "FAMILY SUITE",
        "nm_jenis": "FAMILY SUITE",
        "id_cm": "2017200000000000005",
        "rooms": [
          {
            "no_room": "115",
            "nama_room": "111 TWO BEDROOM",
            "jenis": "FAMILY SUITE",
            "urut": "11",
            "nm_jenis": "FAMILY SUITE",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          }
        ]
      },
      {
        "kd_jenis": "SUPERIOR ROOM",
        "nm_jenis": "SUPERIOR ROOM",
        "id_cm": "2017200000000000006",
        "rooms": [
          {
            "no_room": "111",
            "nama_room": "112 ONE BEDROOM",
            "jenis": "SUPERIOR ROOM",
            "urut": "12",
            "nm_jenis": "SUPERIOR ROOM",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          }
        ]
      },
      {
        "kd_jenis": "DEDARI VILLA",
        "nm_jenis": "DEDARI VILLA",
        "id_cm": "2017200000000000003",
        "rooms": [
          {
            "no_room": "101",
            "nama_room": "101 ONE BEDROOM VILLA",
            "jenis": "DEDARI VILLA",
            "urut": "1",
            "nm_jenis": "DEDARI VILLA",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          },
          {
            "no_room": "102",
            "nama_room": "102 ONE BEDROOM VILLA",
            "jenis": "DEDARI VILLA",
            "urut": "2",
            "nm_jenis": "DEDARI VILLA",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          },
          {
            "no_room": "105",
            "nama_room": "105 ONE BEDROOM VILLA",
            "jenis": "DEDARI VILLA",
            "urut": "5",
            "nm_jenis": "DEDARI VILLA",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          },
          {
            "no_room": "110",
            "nama_room": "110 ONE BEDROOM VILLA",
            "jenis": "DEDARI VILLA",
            "urut": "10",
            "nm_jenis": "DEDARI VILLA",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          }
        ]
      },
      {
        "kd_jenis": "DELUXE ROOM",
        "nm_jenis": "DELUXE ROOM",
        "id_cm": "2017200000000000004",
        "rooms": [
          {
            "no_room": "106",
            "nama_room": "106 ONE BEDROOM",
            "jenis": "DELUXE ROOM",
            "urut": "6",
            "nm_jenis": "DELUXE ROOM",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          },
          {
            "no_room": "107",
            "nama_room": "107 ONE BEDROOM",
            "jenis": "DELUXE ROOM",
            "urut": "7",
            "nm_jenis": "DELUXE ROOM",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          },
          {
            "no_room": "108",
            "nama_room": "108 ONE BEDROOM",
            "jenis": "DELUXE ROOM",
            "urut": "8",
            "nm_jenis": "DELUXE ROOM",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          },
          {
            "no_room": "109",
            "nama_room": "109 ONE BEDROOM",
            "jenis": "DELUXE ROOM",
            "urut": "9",
            "nm_jenis": "DELUXE ROOM",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          }
        ]
      },
      {
        "kd_jenis": "STANDARD DOUBLE",
        "nm_jenis": "STANDARD DOUBLE",
        "id_cm": "2017200000000000007",
        "rooms": [
          {
            "no_room": "112",
            "nama_room": "115 STANDARD DOUBLE ROOM",
            "jenis": "STANDARD DOUBLE",
            "urut": "13",
            "nm_jenis": "STANDARD DOUBLE",
            "available": "1",
            "dummy": 0,
            "backpack": "0.00",
            "villa": "0.00",
            "katagori": "0.00",
            "hotel": "1.00",
            "meeting": "0.00",
            "meetingc": "0.00",
            "non_ota": "0",
            "unlocated": "0",
            "price": 0,
            "maskprice": "0",
            "bookeepingrate": 1,
            "breakfast": "",
            "extranom": "0",
            "total": 0,
            "lama": 0,
            "children": 0,
            "extra": 0
          }
        ]
      }
    ]
  }
};

  static final Map dataEvent = {
  "response": 200,
  "message": "Room Available",
  "status": true,
  "param": {
    "outlet": "1",
    "start": "2020-12-24",
    "end": "2020-12-25",
    "roomType": null,
    "roomFilter": null
  },
  "data": {
    "data": [
      {
        "id": "RES/2011/MZSY4",
        "roomId": "107",
        "room_name": "107 ONE BEDROOM",
        "dummy": 0,
        "checkIn": "2021-01-23",
        "checkOut": "2021-01-24",
        "guestId": "G201118MZSY5",
        "guestName": "Rizki Septiana -2",
        "reservationNumber": "RES/2011/MZSY4",
        "registrationNumber": "REG/2012/VR7IU",
        "nationality": "INDONESIAN               ",
        "roomStatus": "IN HOUSE",
        "backgroundColor": "#B30000",
        "fontColor": "#000000",
        "adult": "2",
        "child": "0",
        "currency": "IDR",
        "bookeepingRate": 0,
        "roomRate": "1.00",
        "deposit": 0,
        "bookingSource": "4. ONLINE TRAVEL AGENT",
        "agent": {
          "kd_cus": "AGN-NK61G",
          "last_name": "",
          "first_name": "",
          "gt": "",
          "saldo_ar": "0.00",
          "nm_cus": "BOOKING.COM (HOTEL COLLECT)",
          "kd_agen": "XX",
          "nama_agen": "",
          "alamat": "                                                                                                    ",
          "tgl_aktif": "0000-00-00",
          "coa_piut": "",
          "telpon": "",
          "hp": "",
          "fax": "                    ",
          "ket": "                                                                                                    ",
          "coa_ar": "          ",
          "nama": "",
          "email": "",
          "kat": "5",
          "contact": "ANN- MARIE VOGT",
          "ndiskon": "0.00",
          "AKTIF": 1,
          "disc_stt": "1",
          "jns_limit": "0",
          "limit_ar": "0.00",
          "DISKON": 0,
          "NM_JENIS": "",
          "komisi_sen": "18.00",
          "stt_komisi": "1",
          "ota": "1",
          "paid_komisi": "1",
          "komisi2": "0.00",
          "ap_komsen": "0.00",
          "stt_tax": "0",
          "nasional": null,
          "id_member": "",
          "stt_valid": 0,
          "valid_date": "0000-00-00",
          "cdept": "",
          "no_id": "",
          "klm": 1,
          "tgl_lahir": "0000-00-00",
          "nodisc": "0",
          "disc_alcohol": "0",
          "disc_ha": "0",
          "pin_cus": "",
          "tot_poin": "0",
          "disc_spa": "0",
          "repeater": "0.00",
          "ratecode": "",
          "cm_cus": "Booking.com.hc",
          "disc_hf": "0",
          "disc_hb": "0",
          "disc_ho": "0",
          "disc_hs": "0",
          "dob": null,
          "pob": "",
          "gender": "",
          "nasionality": "",
          "blacklist": "0",
          "pc_id": "GUNTURKRISNA-PC ",
          "tcp_id": "192.168.192.151",
          "login_id": "ADMIN                         ",
          "dbupdate": "2020-11-23 14:32:50",
          "ar": "1",
          "disc_food": "0",
          "diSC_BVR": "0",
          "disc_sisha": "0.00",
          "diSC_OTH": "0",
          "diSC_SHISHA": "0",
          "group_cus": "0",
          "input_kom": "1.00",
          "input_ap": "0.00",
          "logo": null,
          "joiner": "0",
          "groups": "",
          "taxser": "0.00",
          "com_cm": "0.00",
          "birthday": "1000-01-01",
          "age": 0,
          "email_show": ""
        },
        "memo": "",
        "roomDestinationId": 4,
        "bookingType": "single",
        "breakfast": "2",
        "jenis_room": "DELUXE ROOM",
        "price": "360750.00",
        "source": "4. ONLINE TRAVEL AGENT",
        "formatPrice": "360.750",
        "no_res": "RES/2011/MZSY4",
        "nama_tamu": "Rizki Septiana -2",
        "no_room": "107",
        "pax": "2",
        "tgl_datang": {
          "date": "2020-12-23 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "tgl_berang": {
          "date": "2020-12-24 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "hrg_room": "360750.00",
        "jenis": "DELUXE ROOM",
        "kd_agen": "AGN-NK61G",
        "email": "guest@mail.com",
        "rate": "1.00",
        "nasional": "",
        "edit_ket": "",
        "edit_nom": "0.00",
        "user": "FERRY                         ",
        "nm_makan": "BREAKFAST                     ",
        "hrg_makan": "30000.00",
        "gsegment": null,
        "ginfo": "",
        "telpon": "",
        "kd_tamu": "G201118MZSY5",
        "nama_group": "RIZKI SEPTIANA",
        "pax_freebf": "2",
        "country": "INDONESIAN               ",
        "no_hp": "111                           ",
        "vip": "0",
        "titleTamu": "Mr  ",
        "reg_stt": "OUT",
        "status": "OC",
        "phoneCode": "",
        "previewPrice": "360.750",
        "totalPrice": "360.750",
        "voucher_id": "",
        "no_cm": "",
        "statusData": false,
        "stt": "REGISTERED",
        "no_ref": "REFMZ7T9",
        "ota_country": "",
        "bookedDate": {
          "date": "2020-11-18 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "statusBooking": "REGISTERED",
        "lastUser": "",
        "userm": "",
        "lama": "1",
        "reservasiDateData": [
          {
            "no_ref": "REFMZ7T9",
            "no_res": "RES/2011/MZSY4",
            "no_room": "107",
            "rdate": "2020-12-23 00:00:00",
            "typebook": "EAC",
            "typeday": "OC",
            "rprice": "0.00",
            "room_rp": "360750.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-11-18 10:44:01",
            "dbupdate": "2020-12-23 14:48:57",
            "insert_by": "FERRY",
            "pc_id": "GUNTURKRISNA-PC ",
            "ket_id": "",
            "rate_bf": "30000.00",
            "tpax": "2.00",
            "komisi": "64935.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "2.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW",
            "tanggal": null,
            "komisi_sen": "18.00",
            "sortdate": "2020-12-23",
            "res": "MZSY4",
            "formatrdate": "23-12-2020"
          },
          {
            "no_ref": "REFMZ7T9",
            "no_res": "RES/2011/MZSY4",
            "no_room": "107",
            "rdate": "2020-12-24 00:00:00",
            "typebook": "D",
            "typeday": "D",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-11-18 10:44:01",
            "dbupdate": "2020-12-23 14:48:57",
            "insert_by": "FERRY",
            "pc_id": "GUNTURKRISNA-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "0.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "D",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "2.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW",
            "tanggal": null,
            "komisi_sen": "18.00",
            "sortdate": "2020-12-24",
            "res": "MZSY4",
            "formatrdate": "24-12-2020"
          }
        ],
        "depositDetail": [],
        "res": "MZSY4",
        "reservasiDatePrice": {
          "2020-12-23": "360750.00",
          "2020-12-24": "0.00"
        }
      },
      {
        "id": "RES/2012/ST5KC",
        "roomId": "105",
        "room_name": "105 ONE BEDROOM VILLA",
        "dummy": 0,
        "checkIn": "2021-01-25",
        "checkOut": "2021-01-26",
        "guestId": "G201215T350U",
        "guestName": "Pak Yuyu And Fam Booked By Pak Fendy",
        "reservationNumber": "RES/2012/ST5KC",
        "registrationNumber": "REG/2012/WLOJC",
        "nationality": "INDONESIAN                    ",
        "roomStatus": "COMPLIMENT",
        "backgroundColor": "#E7FF52",
        "fontColor": "#000000",
        "adult": "2",
        "child": "0",
        "currency": "IDR",
        "bookeepingRate": 0,
        "roomRate": "1.00",
        "deposit": 0,
        "bookingSource": "2. DIRECT WALK IN",
        "agent": "",
        "memo": "",
        "roomDestinationId": 4,
        "bookingType": "single",
        "breakfast": "0",
        "jenis_room": "DEDARI VILLA",
        "price": "0.00",
        "source": "2. DIRECT WALK IN",
        "formatPrice": "0",
        "no_res": "RES/2012/ST5KC",
        "nama_tamu": "Pak Yuyu And Fam Booked By Pak Fendy",
        "no_room": "105",
        "pax": "2",
        "tgl_datang": {
          "date": "2020-12-25 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "tgl_berang": {
          "date": "2020-12-26 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "hrg_room": "0.00",
        "jenis": "DEDARI VILLA",
        "kd_agen": "",
        "email": "guest@mail.com",
        "rate": "1.00",
        "nasional": "",
        "edit_ket": "                              ",
        "edit_nom": "0.00",
        "user": "DWIKA                         ",
        "nm_makan": "                              ",
        "hrg_makan": "0.00",
        "gsegment": null,
        "ginfo": "",
        "telpon": "               ",
        "kd_tamu": "G201215T350U",
        "nama_group": "",
        "pax_freebf": "0",
        "country": "INDONESIAN                    ",
        "no_hp": "123",
        "vip": "0",
        "titleTamu": "Mr  ",
        "reg_stt": "OUT",
        "status": "COM",
        "phoneCode": "",
        "previewPrice": "0",
        "totalPrice": "0",
        "voucher_id": "",
        "no_cm": "",
        "statusData": false,
        "stt": "REGISTERED",
        "no_ref": "",
        "ota_country": "                              ",
        "bookedDate": {
          "date": "2020-12-15 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "statusBooking": "REGISTERED",
        "lastUser": "DWIKA                         ",
        "userm": "",
        "lama": "1",
        "reservasiDateData": [
          {
            "no_ref": "",
            "no_res": "RES/2012/ST5KC",
            "no_room": "105",
            "rdate": "2020-12-25 00:00:00",
            "typebook": "COM",
            "typeday": "COM",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-25 15:11:12",
            "dbupdate": "2020-12-25 15:12:38",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "2.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "                              ",
            "kd_season": "LOW       ",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-25",
            "res": "ST5KC",
            "formatrdate": "25-12-2020"
          },
          {
            "no_ref": "",
            "no_res": "RES/2012/ST5KC",
            "no_room": "105",
            "rdate": "2020-12-26 00:00:00",
            "typebook": "D",
            "typeday": "D",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-25 15:11:12",
            "dbupdate": "2020-12-25 15:12:38",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "0.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "D",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW       ",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-26",
            "res": "ST5KC",
            "formatrdate": "26-12-2020"
          }
        ],
        "depositDetail": [],
        "res": "ST5KC",
        "reservasiDatePrice": {
          "2020-12-25": "0.00",
          "2020-12-26": "0.00"
        }
      },
      {
        "id": "RES/2012/SQSYA",
        "roomId": "103",
        "room_name": "103 ONE BEDROOM VILLA",
        "dummy": 0,
        "checkIn": "2021-01-25",
        "checkOut": "2021-01-26",
        "guestId": "G201215T5LN3",
        "guestName": "Pak Yuyu And Fam Booked By Pak Fendy",
        "reservationNumber": "RES/2012/SQSYA",
        "registrationNumber": "REG/2012/WJK0M",
        "nationality": "INDONESIAN                    ",
        "roomStatus": "COMPLIMENT",
        "backgroundColor": "#E7FF52",
        "fontColor": "#000000",
        "adult": "2",
        "child": "0",
        "currency": "IDR",
        "bookeepingRate": 0,
        "roomRate": "1.00",
        "deposit": 0,
        "bookingSource": "2. DIRECT WALK IN",
        "agent": "",
        "memo": "",
        "roomDestinationId": 4,
        "bookingType": "single",
        "breakfast": "0",
        "jenis_room": "DEDARI VILLA",
        "price": "0.00",
        "source": "2. DIRECT WALK IN",
        "formatPrice": "0",
        "no_res": "RES/2012/SQSYA",
        "nama_tamu": "Pak Yuyu And Fam Booked By Pak Fendy",
        "no_room": "103",
        "pax": "2",
        "tgl_datang": {
          "date": "2020-12-25 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "tgl_berang": {
          "date": "2020-12-26 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "hrg_room": "0.00",
        "jenis": "DEDARI VILLA",
        "kd_agen": "",
        "email": "guest@mail.com",
        "rate": "1.00",
        "nasional": "",
        "edit_ket": "                              ",
        "edit_nom": "0.00",
        "user": "DWIKA                         ",
        "nm_makan": "                              ",
        "hrg_makan": "0.00",
        "gsegment": null,
        "ginfo": "",
        "telpon": "               ",
        "kd_tamu": "G201215T5LN3",
        "nama_group": "",
        "pax_freebf": "0",
        "country": "INDONESIAN                    ",
        "no_hp": "123                           ",
        "vip": "0",
        "titleTamu": "Mr  ",
        "reg_stt": "OUT",
        "status": "COM",
        "phoneCode": "",
        "previewPrice": "0",
        "totalPrice": "0",
        "voucher_id": "",
        "no_cm": "",
        "statusData": false,
        "stt": "REGISTERED",
        "no_ref": "",
        "ota_country": "                              ",
        "bookedDate": {
          "date": "2020-12-15 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "statusBooking": "REGISTERED",
        "lastUser": "DWIKA                         ",
        "userm": "",
        "lama": "1",
        "reservasiDateData": [
          {
            "no_ref": "",
            "no_res": "RES/2012/SQSYA",
            "no_room": "103",
            "rdate": "2020-12-25 00:00:00",
            "typebook": "COM",
            "typeday": "COM",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-25 15:09:57",
            "dbupdate": "2020-12-25 15:10:59",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "2.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "                              ",
            "kd_season": "LOW       ",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-25",
            "res": "SQSYA",
            "formatrdate": "25-12-2020"
          },
          {
            "no_ref": "",
            "no_res": "RES/2012/SQSYA",
            "no_room": "103",
            "rdate": "2020-12-26 00:00:00",
            "typebook": "D",
            "typeday": "D",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-25 15:09:57",
            "dbupdate": "2020-12-25 15:10:59",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "0.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "D",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW       ",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-26",
            "res": "SQSYA",
            "formatrdate": "26-12-2020"
          }
        ],
        "depositDetail": [],
        "res": "SQSYA",
        "reservasiDatePrice": {
          "2020-12-25": "0.00",
          "2020-12-26": "0.00"
        }
      },
      {
        "id": "RES/2012/Y0YFR",
        "roomId": "115",
        "room_name": "111 TWO BEDROOM",
        "dummy": 0,
        "checkIn": "2021-02-25",
        "checkOut": "2021-02-28",
        "guestId": "G201125G0OYH",
        "guestName": "Shared Room",
        "reservationNumber": "RES/2012/Y0YFR",
        "registrationNumber": "",
        "nationality": "",
        "roomStatus": "",
        "backgroundColor": "#0073b7",
        "fontColor": "#000000",
        "adult": "1",
        "child": "0",
        "currency": "IDR",
        "bookeepingRate": 0,
        "roomRate": "1.00",
        "deposit": 0,
        "bookingSource": "1. WEB",
        "agent": "",
        "memo": "",
        "roomDestinationId": 4,
        "bookingType": "single",
        "breakfast": "0",
        "jenis_room": "FAMILY SUITE",
        "price": "0.00",
        "source": "1. WEB",
        "formatPrice": "0",
        "no_res": "RES/2012/Y0YFR",
        "nama_tamu": "Shared Room",
        "no_room": "115",
        "pax": "1",
        "tgl_datang": {
          "date": "2020-12-25 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "tgl_berang": {
          "date": "2020-12-28 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "hrg_room": "0.00",
        "jenis": "FAMILY SUITE",
        "kd_agen": "",
        "email": "",
        "rate": "1.00",
        "nasional": "",
        "edit_ket": "                              ",
        "edit_nom": "0.00",
        "user": "DWIKA                         ",
        "nm_makan": "                              ",
        "hrg_makan": "0.00",
        "gsegment": null,
        "ginfo": "",
        "telpon": "               ",
        "kd_tamu": "G201125G0OYH",
        "nama_group": "",
        "pax_freebf": "0",
        "country": "",
        "no_hp": "                              ",
        "vip": "0",
        "titleTamu": "Mr  ",
        "reg_stt": "",
        "status": "SH",
        "phoneCode": "",
        "previewPrice": "0",
        "totalPrice": "0",
        "voucher_id": "",
        "no_cm": "",
        "statusData": false,
        "stt": "SHARED",
        "no_ref": "",
        "ota_country": "                              ",
        "bookedDate": {
          "date": "2020-12-10 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "statusBooking": "SHARED",
        "lastUser": "DWIKA                         ",
        "userm": "",
        "lama": "3",
        "reservasiDateData": [
          {
            "no_ref": "",
            "no_res": "RES/2012/Y0YFR",
            "no_room": "115",
            "rdate": "2020-12-25 00:00:00",
            "typebook": "SH",
            "typeday": "",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-26 11:28:27",
            "dbupdate": "0000-00-00 00:00:00",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "1.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-25",
            "res": "Y0YFR",
            "formatrdate": "25-12-2020"
          },
          {
            "no_ref": "",
            "no_res": "RES/2012/Y0YFR",
            "no_room": "115",
            "rdate": "2020-12-26 00:00:00",
            "typebook": "SH",
            "typeday": "",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-26 11:28:27",
            "dbupdate": "0000-00-00 00:00:00",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "1.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-26",
            "res": "Y0YFR",
            "formatrdate": "26-12-2020"
          },
          {
            "no_ref": "",
            "no_res": "RES/2012/Y0YFR",
            "no_room": "115",
            "rdate": "2020-12-27 00:00:00",
            "typebook": "SH",
            "typeday": "",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-26 11:28:27",
            "dbupdate": "0000-00-00 00:00:00",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "1.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-27",
            "res": "Y0YFR",
            "formatrdate": "27-12-2020"
          },
          {
            "no_ref": "",
            "no_res": "RES/2012/Y0YFR",
            "no_room": "115",
            "rdate": "2020-12-28 00:00:00",
            "typebook": "D",
            "typeday": "",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-12-26 11:28:27",
            "dbupdate": "0000-00-00 00:00:00",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "0.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "D",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "0.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-28",
            "res": "Y0YFR",
            "formatrdate": "28-12-2020"
          }
        ],
        "depositDetail": [],
        "res": "Y0YFR",
        "reservasiDatePrice": {
          "2020-12-25": "0.00",
          "2020-12-26": "0.00",
          "2020-12-27": "0.00",
          "2020-12-28": "0.00"
        }
      },
      {
        "id": "RES/2011/N603D",
        "roomId": "106",
        "room_name": "106 ONE BEDROOM",
        "dummy": 0,
        "checkIn": "2021-01-25",
        "checkOut": "2021-01-26",
        "guestId": "G201118N544Y",
        "guestName": "Anissa Maharani Halim",
        "reservationNumber": "RES/2011/N603D",
        "registrationNumber": "REG/2012/R5L4T",
        "nationality": "INDONESIAN                    ",
        "roomStatus": "IN HOUSE",
        "backgroundColor": "#B30000",
        "fontColor": "#000000",
        "adult": "2",
        "child": "0",
        "currency": "IDR",
        "bookeepingRate": 0,
        "roomRate": "1.00",
        "deposit": 0,
        "bookingSource": "4. ONLINE TRAVEL AGENT",
        "agent": {
          "kd_cus": "AGN-NKTWC",
          "last_name": "",
          "first_name": "",
          "gt": "",
          "saldo_ar": "0.00",
          "nm_cus": "AGODA (AGENT COLLECT)",
          "kd_agen": "XX",
          "nama_agen": "",
          "alamat": "                                                                                                    ",
          "tgl_aktif": "0000-00-00",
          "coa_piut": "",
          "telpon": "",
          "hp": "",
          "fax": "                    ",
          "ket": "                                                                                                    ",
          "coa_ar": "          ",
          "nama": "",
          "email": "",
          "kat": "5",
          "contact": "",
          "ndiskon": "0.00",
          "AKTIF": 1,
          "disc_stt": "1",
          "jns_limit": "0",
          "limit_ar": "0.00",
          "DISKON": 0,
          "NM_JENIS": "",
          "komisi_sen": "0.00",
          "stt_komisi": "1",
          "ota": "1",
          "paid_komisi": "2",
          "komisi2": "0.00",
          "ap_komsen": "0.00",
          "stt_tax": "0",
          "nasional": null,
          "id_member": "",
          "stt_valid": 0,
          "valid_date": "0000-00-00",
          "cdept": "",
          "no_id": "",
          "klm": 1,
          "tgl_lahir": "0000-00-00",
          "nodisc": "0",
          "disc_alcohol": "0",
          "disc_ha": "0",
          "pin_cus": "",
          "tot_poin": "0",
          "disc_spa": "0",
          "repeater": "0.00",
          "ratecode": "",
          "cm_cus": "Agoda.ac",
          "disc_hf": "0",
          "disc_hb": "0",
          "disc_ho": "0",
          "disc_hs": "0",
          "dob": null,
          "pob": "",
          "gender": "",
          "nasionality": "",
          "blacklist": "0",
          "pc_id": "KASIR-PC ",
          "tcp_id": "192.168.1.100",
          "login_id": "PUTU      ",
          "dbupdate": "2020-04-03 12:13:50",
          "ar": "1",
          "disc_food": "0",
          "diSC_BVR": "0",
          "disc_sisha": "0.00",
          "diSC_OTH": "0",
          "diSC_SHISHA": "0",
          "group_cus": "0",
          "input_kom": "0.00",
          "input_ap": "0.00",
          "logo": null,
          "joiner": "0",
          "groups": "",
          "taxser": "0.00",
          "com_cm": "0.00",
          "birthday": "1000-01-01",
          "age": 0,
          "email_show": ""
        },
        "memo": "",
        "roomDestinationId": 4,
        "bookingType": "single",
        "breakfast": "2",
        "jenis_room": "DELUXE ROOM",
        "price": "251443.00",
        "source": "4. ONLINE TRAVEL AGENT",
        "formatPrice": "251.443",
        "no_res": "RES/2011/N603D",
        "nama_tamu": "Anissa Maharani Halim",
        "no_room": "106",
        "pax": "2",
        "tgl_datang": {
          "date": "2020-12-25 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "tgl_berang": {
          "date": "2020-12-26 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "hrg_room": "251443.00",
        "jenis": "DELUXE ROOM",
        "kd_agen": "AGN-NKTWC",
        "email": "guest@mail.com",
        "rate": "1.00",
        "nasional": "",
        "edit_ket": "                              ",
        "edit_nom": "0.00",
        "user": "DWIKA                         ",
        "nm_makan": "BREAKFAST                     ",
        "hrg_makan": "30000.00",
        "gsegment": null,
        "ginfo": "",
        "telpon": "               ",
        "kd_tamu": "G201118N544Y",
        "nama_group": "",
        "pax_freebf": "2",
        "country": "INDONESIAN                    ",
        "no_hp": "111                           ",
        "vip": "0",
        "titleTamu": "Mrs ",
        "reg_stt": "OUT",
        "status": "OC",
        "phoneCode": "",
        "previewPrice": "251.443",
        "totalPrice": "251.443",
        "voucher_id": "513639493",
        "no_cm": "",
        "statusData": false,
        "stt": "REGISTERED",
        "no_ref": "",
        "ota_country": "                              ",
        "bookedDate": {
          "date": "2020-11-18 00:00:00.000000",
          "timezone_type": 3,
          "timezone": "Asia/Singapore"
        },
        "statusBooking": "REGISTERED",
        "lastUser": "DWIKA                         ",
        "userm": "",
        "lama": "1",
        "reservasiDateData": [
          {
            "no_ref": "",
            "no_res": "RES/2011/N603D",
            "no_room": "106",
            "rdate": "2020-12-25 00:00:00",
            "typebook": "EAC",
            "typeday": "OC",
            "rprice": "0.00",
            "room_rp": "251443.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-11-19 19:56:17",
            "dbupdate": "2020-12-25 12:40:09",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "30000.00",
            "tpax": "2.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "I",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "2.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "                              ",
            "kd_season": "LOW       ",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-25",
            "res": "N603D",
            "formatrdate": "25-12-2020"
          },
          {
            "no_ref": "",
            "no_res": "RES/2011/N603D",
            "no_room": "106",
            "rdate": "2020-12-26 00:00:00",
            "typebook": "D",
            "typeday": "D",
            "rprice": "0.00",
            "room_rp": "0.00",
            "room_usd": "0.00",
            "other_inc": "0.00",
            "br": "1.00",
            "dbinsert": "2020-11-19 19:56:17",
            "dbupdate": "2020-12-25 12:40:09",
            "insert_by": "DWIKA",
            "pc_id": "DEDARI-PC ",
            "ket_id": "",
            "rate_bf": "0.00",
            "tpax": "0.00",
            "komisi": "0.00",
            "tra": "0.00",
            "disc_sen": "0.00",
            "disc_nom": "0.00",
            "move_bill": "0.00",
            "dummy_nom": "0.00",
            "masuk": "D",
            "tgl_closecc": "0000-00-00",
            "aversi": "6.6.69",
            "pax_bf": "2.00",
            "extra_bed": "0.00",
            "rebate": "0.00",
            "nm_extrabed": "",
            "tgl_cancel": "0000-00-00",
            "ratecode": "",
            "kd_season": "LOW       ",
            "tanggal": null,
            "komisi_sen": "0.00",
            "sortdate": "2020-12-26",
            "res": "N603D",
            "formatrdate": "26-12-2020"
          }
        ],
        "depositDetail": [],
        "res": "N603D",
        "reservasiDatePrice": {
          "2020-12-25": "251443.00",
          "2020-12-26": "0.00"
        }
      }
    ]
  }
};
}