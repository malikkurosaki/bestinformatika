import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:probus_mobile/model_calendar/model_list_booking.dart';
import 'package:probus_mobile/model_calendar/model_room_type.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:synchronized/synchronized.dart';



// class CobaCtrl extends MyCtrl{
//   static final scrollController = TrackingScrollController().obs;
// }

class CalendarCoba extends StatelessWidget{
  static final lsBooking = <ModelListBooking>[].obs;
  static final lsRoomType = <ModelRoomType>[].obs;
  static final debugValue = [].obs;
  static final lsCalendar = List.generate(12, (index) => Calendar(DateTime(2021, index + 1)));
  // static final scrollController = TrackingScrollController().obs;
  final scroll1 = ScrollController();
  final scroll2 = ScrollController();
  final scroll3 = ScrollController();
  final scroll4 = ScrollController();


  final GlobalKey tinggi = GlobalKey();
  static final tingginya = 0.0.obs;
 
  @override
  Widget build(BuildContext context) => 
  Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[200],
            height: Get.width / 8,
            child: Row(
              children: [
                BackButton(),
                FutureBuilder(
                  future: init(),
                  builder: (context, snapshot) => 
                  snapshot.connectionState != ConnectionState.done?
                  Text("loading ..."):
                  Row(
                    children: [
                      Text("Calendar Booking"),
                      TextButton(
                        onPressed: (){
                          Get.dialog(Card(child: SingleChildScrollView(child: Column(
                            children: [
                              BackButton(),
                              Text(JsonEncoder.withIndent(" ").convert(debugValue.toJson()),),
                            ],
                          ))));
                        }, 
                        child: Text("debuh")
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[200],
                  width: Get.width / 8,
                  child: Column(
                    children: [
                      Container(
                        height: (Get.width - (Get.width / 8))  / 7,
                        child: Text("room type")
                      ),
                      Container(
                        height: (Get.width - (Get.width / 8))  / 7,
                      ),
                      /// disamping tanggal
                      Flexible(
                        child: Container(
                          color: Colors.grey[200],
                          child: Obx(
                            () => 
                            ListView(
                              key: tinggi,
                              physics: BouncingScrollPhysics(),
                              controller: scroll1,
                              children: [
                                for(final rt in lsRoomType)
                                Column(
                                  children: [
                                    Container(
                                      height: (Get.width - (Get.width / 8))  / 7,
                                      // child: Text(rt?.nmJenis?.toString()?.toLowerCase()??"",
                                      //   overflow: TextOverflow.clip,
                                      //   style: TextStyle(
                                      //     fontSize: 12
                                      //   ),
                                      // ),
                                    ),
                                    Column(
                                      children: [
                                        for(final rm in rt.rooms)
                                        Container(
                                          height: (Get.width - (Get.width / 8))  / 7,
                                          child: Center(
                                            child: Text(rm.noRoom?.toString()??"")
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ),
                        )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: ((Get.width - (Get.width / 8)) / 7) * 2,
                        child: ListView(
                          controller: scroll3,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            for(final cal in lsCalendar)
                            Container(
                              width: (Get.width - (Get.width / 8)) * cal.perWeek.length,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: (Get.width - (Get.width / 8))  / 7,
                                    child: Row(
                                      children: [
                                        Text(cal.year.toString()),
                                        Text(" - "),
                                        Text(cal.month.toString()),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Row(
                                      children: [
                                        for(final w in cal.perWeek)
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width - (Get.width / 8),
                                                child: Row(
                                                  children: [
                                                    for(final d in w)
                                                    Expanded(
                                                      child: Container(
                                                        height: (Get.width - (Get.width / 8))  / 7,
                                                        width: (Get.width - (Get.width / 8)) / 7,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(width: 0.1)
                                                        ),
                                                        // width: Get.width / 7,
                                                        child: Center(
                                                          child: Text(d['date'].toString(),
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: d['type'] == 0? Colors.grey: Colors.black,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          )
                                                        )
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                      /// conten ditengan tengah
                      Expanded(
                      child: Container(
                          height: tingginya.value,
                          child: ListView(
                            controller: scroll2,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Obx(
                                () => tingginya.value == 0.0?Text("loading"):
                                Container(
                                  color: Colors.grey,
                                  height: tingginya.value,
                                  child: ListView(
                                    controller: scroll4,
                                    scrollDirection: Axis.horizontal,
                                    physics: PageScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      for(final cal in lsCalendar)
                                      Container(
                                        width: (Get.width - (Get.width / 8)) * cal.perWeek.length,
                                        child: Row(
                                          children: [
                                            for(final w in cal.perWeek)
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  for(final rt in lsRoomType)
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        height: (Get.width - (Get.width / 8))  / 7,
                                                        child: Text(rt?.nmJenis?.toString()??"",
                                                          overflow: TextOverflow.clip,
                                                          style: TextStyle(
                                                            fontSize: 18
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          for(final rm in rt.rooms)
                                                          Container(
                                                            height: (Get.width - (Get.width / 8))  / 7,
                                                            /// lanjut calendar
                                                            child: Row(
                                                              children: [
                                                                for(final d in w)
                                                                 Expanded(
                                                                  child: d['type'] == 0? SizedBox.shrink()
                                                                  :Stack(
                                                                    children: [
                                                                      for(final lb in lsBooking)
                                                                      d['date'] == 1? 
                                                                        TextButton(
                                                                          onPressed: () => Get.snackbar("title", lb.checkIn), 
                                                                          child: Text("oo")
                                                                        )
                                                                      : SizedBox.shrink()
                                                                    ],
                                                                  )
                                                                )
                                                              ],
                                                            )
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                
              ],
            )
          )
        ],
      ),
    ),
  );


  static List<ModelRoomType> prosesRoomType(dynamic data){
    return (data as List).map((e) => ModelRoomType.fromJson(e)).toList();
  }

  static loadRoomType()async{
    final Response resType = await RestApi.roomType();
    return compute(prosesRoomType, resType.body['data']['data']);
  }


  static List<ModelListBooking> prossesListBooking(dynamic data){
    return (data as List).map((e) => ModelListBooking.fromJson(e)).toList();
  }
  static loadListBooking()async{
    final Response res = await RestApi.listBooking("2021-01-01", "2021-12-31");
    debugValue.assignAll(res.body['data']['data']);
    return compute(prossesListBooking, res.body['data']['data']);
  }
 

  init()async{
    // await Future.delayed(Duration(seconds: 5));

    // final Response res = await RestApi.listBooking("2021-01-01", "2021-12-31");

    final lock1 = new Lock();
    final lock2 = new Lock();
    final lock3 = new Lock();

    lock1.synchronized(() async{
      lsRoomType.assignAll(await loadRoomType());
      print("load 1");

      lock3.synchronized(() {
        final tg = tinggi.currentContext.height + ((Get.width / 8) * 2.6);

        print("load 3");
        tingginya.value = tg;
      });
    });

    lock2.synchronized(() async{
      lsBooking.assignAll(await loadListBooking());
      print("load 2");
    });

    scroll2.addListener(() {
      scroll1.jumpTo(scroll2.position.pixels);
    });

    scroll4.addListener(() {
      scroll3.jumpTo(scroll4.position.pixels);
    });
  }


}


// class ShowInfoBooking extends StatelessWidget {
//   final ModelBooking booking;

//   const ShowInfoBooking({Key key, this.booking}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       builder: (context, scrollController) => 
//       Card(
//         child: Container(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             children: [
//               Text(booking.guestName,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               Flexible(
//                 child: ListView(
//                   controller: scrollController,
//                   children: [
                    
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CldV5 extends MyCtrl{
//   static final nameDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday"];
//   static final nameMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "Oktober", "November", "Desember"];
//   static final tahun = DateTime.now().year;

//   static final loadingInit = false.obs;
//   static final loadingRoomType = false.obs;
//   static final loadingBooking = false.obs;

//   static final lsRoomType = <ModelRoomType>[].obs;
//   static final lsBooking = <ModelBooking>[].obs;
//   static final lsCalendar = <Calendar>[].obs;

//   static final tanggalan = DateTime.now().obs;
//   static final scrollController = TrackingScrollController().obs;

//   static final prev = false.obs;
//   static final next = false.obs;
//   static final bulanController = PageController().obs;
//   static final indexWeek = 0.obs;
//   static final deltaDx = 0.0.obs;

//   static init()async{
//     loadingInit.value = true;
//       final kal = await compute(getListCalendar, 0);
//       lsCalendar.assignAll(kal);

//       await getRoomType();
//     loadingInit.value = false;

//     Future.delayed(Duration(seconds: 2),()async{
//       loadingBooking.value = true;
//       final Response res = await RestApi.listBooking("$tahun-01-01", "$tahun-01-31");
//       final List data = res.body['data']['data'];
//       final lb = await compute(getListBooking, data);
      
//       lsBooking.assignAll(lb);
//       loadingBooking.value = false;
//     });
    
//   }

//   static getRoomType()async{
//     loadingRoomType.value = true;
//     if(GetStorage().hasData("roomType")){
//       lsRoomType.assignAll((GetStorage().read("roomType") as List).map((e) => ModelRoomType.fromJson(e)).toList());
//       loadingRoomType.value = false;
//     }

//     final Response res = await RestApi.roomType();
//     // final Response res = await ControllerApi.to.calendarRoomType();
//     final List data = res.body['data']['data'];
//     lsRoomType.assignAll(data.map((e) => ModelRoomType.fromJson(e)).toList());
//     loadingRoomType.value = false;
//   }

//   static getListBooking(List data)async{
    
//     final compress = data.map((e) => 
//       {
//         "roomId": e['roomId'],
//         "checkIn": e['checkIn'],
//         "checkOut": e['checkOut'],
//         "backgroundColor": e['backgroundColor'],
//         "guestName": e['guestName'],
//         "nationality": e['nationality'],
//         "roomStatus": e['roomStatus'],
//         "bookingSource": e['bookingSource'],
//         "pax": e['pax'],
//         "reservationNumber": e['reservationNumber'],
//         "breakfast": e['breakfast'],
//         "weekAwal": Calendar.indexWeek(e['checkIn']),
//         "weekAkhir": Calendar.indexWeek(e['checkOut']),
//         "tanggalAwal": DateTime.parse(e['checkIn']).day,
//         "tanggalAkhir": DateTime.parse(e['checkOut']).day,
//         "bulanAwal": DateTime.parse(e['checkIn']).month,
//         "bulanAkhir": DateTime.parse(e['checkOut']).month,
//         "tahunAwal": DateTime.parse(e['checkIn']).year,
//         "tahunAkhir": DateTime.parse(e['checkOut']).year,
//         "durasi": DateTimeRange(start: DateTime.parse(e['checkIn']), end: DateTime.parse(e['checkOut'])).duration.inDays + 1,
//         "range": List.generate(DateTimeRange(start: DateTime.parse(e['checkIn']), end: DateTime.parse(e['checkOut'])).duration.inDays + 1, (index) => 
//           {
//             "tanggal": DateTime.parse(e['checkIn']).day + (index),
//             "hari": DateTime(DateTime.parse(e['checkIn']).year, DateTime.parse(e['checkIn']).month, DateTime.parse(e['checkIn']).day + (index + 1)).weekday,
//           }
//         )
//       }
//     ).toList();
//     List<ModelBooking> booking = compress.map((e) => ModelBooking.fromJson(e)).toList();
//     return booking;
//   }

//   static Future getListCalendar(int i)async{
//     final List<Calendar> ls = List.generate(12, (index) => Calendar(DateTime(tahun, index + 1, 1)));
//     return ls;
//   }

//   static clickBooking(ModelBooking booking){
//     Get.bottomSheet(ShowInfoBooking(booking: booking,));
//   }
// }

class Calendar {
  List perMonth;
  List perWeek;
  int year;
  int month;
  int day;
  int week;
  int hari;

  Calendar(DateTime dateTime){
    json(dateTime);
  }

  List json(DateTime dateTime){
    final k = dateTime;
    final kal = DateTime(k.year, k.month);
    final totalHari = DateTime(kal.year, kal.month + 1, 0).day;
    //final Map hasil = {};
    var date = 1;
    final ls = List.generate(((kal.weekday + totalHari) / 7).ceil(), (i1) => 
      List.generate(7, (i2) => i1 == 0 && i2 < kal.weekday? 
        { 
          "type": 0,
          "date": kal.subtract(Duration(days: kal.weekday)).day + (i2),
          "week": i1,
          "hari": i2,
          "tahun": "${k.year}",
          "bulan": "${k.month}"
         }: totalHari >= date ?
        { 
          "type": 1, 
          "date": date++,
          "week": i1,
          "hari": i2,
          "tahun": "${k.year}",
          "bulan": "${k.month}"
        }: 
        { 
          "type": 2, 
          "date": i2++,
          "week": i1,
          "hari": i2,
          "tahun": "${k.year}",
          "bulan": "${k.month}"
        }
      )
    );

    this.perMonth = ls.expand((element) => element).toList();
    this.perWeek = ls;
    this.year = kal.year;
    this.month = kal.month;
    this.day = kal.day;
    this.week = ls.map((e) => e.where((element) => element['type'] == 1 && element['date'] == kal.day).toList()).toList().expand((element) => element).toList()[0]['week'];
    return ls;
  }

  static int indexWeek (String tahun){
    final k = DateTime.parse(tahun);
    final kal = DateTime(k.year,k.month);
    final total = DateTime(kal.year, kal.month + 1, 0).day; // calculate total day of mont eg: january 31, february 28, etc
    var date = 1;
    var week = [];
    var indexWeek = 0;
    var hasil = 0;
    for(var i1 = 0; i1 < ((kal.weekday + total) / 7).ceil(); i1++){
      week.add([]);
      for(var i2 = 0; i2 < 7; i2++){
        if(i1 == 0 && i2 < kal.weekday){
        hasil = 0;
        }
        else if(total >= date){
          /// of the recurrence computation if it is the equal as the enforced date
          /// will put index week [i1] to [index_week]
          if(k.day == date){
            indexWeek = i1;
          }
          hasil = date ++;
        }
        else{
          hasil = 0;
        }
        week[i1].add(hasil);
      }
    }
    return indexWeek;
  }
}

// class ModelBooking {
//   var roomId;
//   var checkIn;
//   var checkOut;
//   var backgroundColor;
//   var guestName;
//   var weekAwal;
//   var weekAkhir;
//   var tanggalAwal;
//   var tanggalAkhir;
//   var bulanAwal;
//   var bulanAkhir;
//   var tahunAwal;
//   var tahunAkhir;
//   var durasi;
//   var range;

//   ModelBooking(
//       {this.roomId,
//       this.checkIn,
//       this.checkOut,
//       this.backgroundColor,
//       this.guestName,
//       this.weekAwal,
//       this.weekAkhir,
//       this.tanggalAwal,
//       this.tanggalAkhir,
//       this.bulanAwal,
//       this.bulanAkhir,
//       this.tahunAwal,
//       this.tahunAkhir,
//       this.durasi,
//       this.range});

//   ModelBooking.fromJson(Map<String, dynamic> json) {
//     roomId = json['roomId'];
//     checkIn = json['checkIn'];
//     checkOut = json['checkOut'];
//     backgroundColor = json['backgroundColor'];
//     guestName = json['guestName'];
//     weekAwal = json['weekAwal'];
//     weekAkhir = json['weekAkhir'];
//     tanggalAwal = json['tanggalAwal'];
//     tanggalAkhir = json['tanggalAkhir'];
//     bulanAwal = json['bulanAwal'];
//     bulanAkhir = json['bulanAkhir'];
//     tahunAwal = json['tahunAwal'];
//     tahunAkhir = json['tahunAkhir'];
//     durasi = json['durasi'];
//     range = json['range'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['roomId'] = this.roomId;
//     data['checkIn'] = this.checkIn;
//     data['checkOut'] = this.checkOut;
//     data['backgroundColor'] = this.backgroundColor;
//     data['guestName'] = this.guestName;
//     data['weekAwal'] = this.weekAwal;
//     data['weekAkhir'] = this.weekAkhir;
//     data['tanggalAwal'] = this.tanggalAwal;
//     data['tanggalAkhir'] = this.tanggalAkhir;
//     data['bulanAwal'] = this.bulanAwal;
//     data['bulanAkhir'] = this.bulanAkhir;
//     data['tahunAwal'] = this.tahunAwal;
//     data['tahunAkhir'] = this.tahunAkhir;
//     data['durasi'] = this.durasi;
//     data['range'] = this.range;
//     return data;
//   }
// }