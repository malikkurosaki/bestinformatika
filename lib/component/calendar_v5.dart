import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';
import 'package:get/get.dart';

class CalendarV5 extends StatelessWidget {
  final double lebarnya = Get.width / 8;
  final double tingginya = Get.width / 8;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: GetX(
            initState: (state) => CldV5.init(),
            autoRemove: true,
            builder: (controller) => CldV5.loadingInit.value?
            SizedBox.expand(
              child: Container(
                color: Colors.orange,
                child: Center(
                  child: Text("Calendar Booking ...",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ):
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BackButton(),
                        Text("Calender Booking",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Flexible(
                      child: PageView(
                        controller: CldV5.bulanController.value,
                        children: List.generate(CldV5.lsCalendar.length, (i1) => 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CldV5.lsCalendar[i1].year.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(CldV5.nameMonths[CldV5.lsCalendar[i1].month - 1].toString()),
                              Flexible(
                                child: PageView(
                                  children: List.generate(CldV5.lsCalendar[i1].perWeek.length, (i2) => 
                                    Listener(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: lebarnya
                                              ),
                                              for(final tgl in CldV5.nameDays)
                                              Expanded(
                                                child: Container(
                                                  width: lebarnya,
                                                  alignment: Alignment.center,
                                                  child: Text(tgl.toString().substring(0, 3),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: CldV5.nameDays.indexOf(tgl) == 0?Colors.red: Colors.black
                                                    ),
                                                  )
                                                )
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: lebarnya,
                                                alignment: Alignment.center,
                                                child: Icon(Icons.calendar_today),
                                              ),
                                              for(final tgl in CldV5.lsCalendar[i1].perWeek[i2])
                                              Expanded(
                                                child: Container(
                                                  width: lebarnya,
                                                  height: tingginya,
                                                  alignment: Alignment.center,
                                                  child: Text(tgl['date'].toString())
                                                )
                                              )
                                            ],
                                          ),
                                          Flexible(
                                            child: Listener(
                                              onPointerMove: (event) {
                                                CldV5.deltaDx.value = event.delta.dx;
                                                // print(event.radiusMajor);

                                                if(event.delta.dx > 5){
                                                  // print("prev");
                                                  CldV5.next.value = false;
                                                  CldV5.prev.value = true;
                                                }
                                                else if(event.delta.dx < -5){
                                                  // print("next");
                                                  CldV5.next.value = true;
                                                  CldV5.prev.value = false;
                                                }
                                              },
                                              onPointerUp: (event) {
                                                // print(i2);
                                                // if(CldV5.deltaDx.value < (-5) ){
                                                //   CldV5.bulanController.value.nextPage(curve: Curves.ease, duration: Duration(milliseconds: 500));
                                                // }
                                                // else if(CldV5.deltaDx.value > 5){
                                                //   CldV5.bulanController.value.previousPage(curve: Curves.ease, duration: Duration(milliseconds: 500));
                                                // }

                                                //print(event.delta.dx);
                                                if(CldV5.next.value){
                                                  //print([CldV5.indexWeek, CldV5.lsCalendar[i1].perWeek.length -1]);
                                                  //print([i2, CldV5.lsCalendar[i1].perWeek.indexOf(CldV5.lsCalendar[i1].perWeek.last)]);

                                                  if(i2 == CldV5.lsCalendar[i1].perWeek.indexOf(CldV5.lsCalendar[i1].perWeek.last)){
                                                    CldV5.bulanController.value.nextPage(curve: Curves.ease, duration: Duration(milliseconds: 500));
                                                  }
                                                }
                                                else if(CldV5.prev.value){
                                                  // print([CldV5.indexWeek.value, (CldV5.lsCalendar[i1].perWeek.length - 1)]);
                                                  if(i2 == CldV5.lsCalendar[i1].perWeek.indexOf(CldV5.lsCalendar[i1].perWeek.first)){
                                                    CldV5.bulanController.value.previousPage(curve: Curves.ease, duration: Duration(milliseconds: 500));
                                                  }
                                                }
                                              },
                                              child: ListView(
                                                controller: CldV5.scrollController.value,
                                                children: [
                                                  for(final lsRoom in CldV5.lsRoomType)
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(lsRoom['nm_jenis'].toString(),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      for(final room in lsRoom['rooms'])
                                                      Flexible(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              alignment: Alignment.center,
                                                              width: lebarnya,
                                                              height: tingginya,
                                                              child: Text(room['no_room'].toString())
                                                            ),
                                                            // cek list booking
                                                            //CldV5.loadingBooking.value? SizedBox.shrink():
                                                            Expanded(
                                                              child: Container(
                                                                height: tingginya,
                                                                child: Stack(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        for(final tgl in CldV5.lsCalendar[i1].perWeek[i2])
                                                                        Expanded(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                color: Colors.grey,
                                                                                width: 0.1
                                                                              ),
                                                                            ),
                                                                          )
                                                                        )
                                                                      ],
                                                                    ),
                                                                    for(final booking in CldV5.lsBooking)
                                                                    booking.roomId == room['no_room'] &&
                                                                    booking.tahunAwal == CldV5.lsCalendar[i1].year &&
                                                                    booking.bulanAwal == CldV5.lsCalendar[i1].month?
                                                                    Stack(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            for(final tgl in CldV5.lsCalendar[i1].perWeek[i2])
                                                                            Expanded(
                                                                              child: Stack(
                                                                                children: [
                                                                                  for(final rg in booking.range)
                                                                                  rg['tanggal'] == tgl['date'] && tgl['type'] == 1 || rg['tanggal'] == tgl['date'] && tgl['type'] == 1?
                                                                                  InkWell(
                                                                                    onTap: () => CldV5.clickBooking(booking),
                                                                                    child: Container(
                                                                                      width: lebarnya,
                                                                                      height: tingginya,
                                                                                    ),
                                                                                  ) : SizedBox.shrink()
                                                                                ],
                                                                              )
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            for(final tgl in CldV5.lsCalendar[i1].perWeek[i2])
                                                                            Expanded(                                                        
                                                                              child: booking.weekAwal == tgl['week'] && 
                                                                              booking.tanggalAwal == tgl['date']?
                                                                              OverflowBox(
                                                                                maxWidth: booking.durasi * (Get.width / 8),
                                                                                maxHeight: 50,
                                                                                alignment: Alignment.bottomLeft,
                                                                                child: Card(
                                                                                  elevation: 10,
                                                                                  margin: EdgeInsets.symmetric(horizontal: (Get.width / 8 )/ 1.8),
                                                                                  color: Color(int.parse(booking.backgroundColor.toString().replaceAll("#", "0xff"))),
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(4),
                                                                                    width: booking.durasi * (Get.width / 8),
                                                                                    child: Text(booking.guestName.toString(),
                                                                                      overflow: TextOverflow.clip,
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        backgroundColor: Colors.black26
                                                                                      ),
                                                                                    )
                                                                                  )
                                                                                ),
                                                                              )
                                                                              : booking.weekAkhir == tgl['week'] && booking.weekAkhir != booking.weekAwal&&
                                                                              booking.tanggalAkhir == tgl['date'] ?
                                                                              OverflowBox(
                                                                                maxWidth: booking.durasi * (Get.width / 8),
                                                                                maxHeight: 50,
                                                                                alignment: Alignment.bottomRight,
                                                                                minWidth: booking.durasi * (Get.width / 8),
                                                                                child: 
                                                                                Card(
                                                                                  elevation: 10,
                                                                                  margin: EdgeInsets.symmetric(horizontal: (Get.width / 8 )/ 1.8),
                                                                                  color: Color(int.parse(booking.backgroundColor.toString().replaceAll("#", "0xff"))),
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.all(4),
                                                                                    width: booking.durasi * (Get.width / 8),
                                                                                    child: Text(booking.guestName.toString(),
                                                                                      textAlign: TextAlign.end,
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        backgroundColor: Colors.black26
                                                                                      ),
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                    )
                                                                                  )
                                                                                ),
                                                                              )
                                                                              : SizedBox.shrink()
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )
                                                                    : SizedBox.shrink()
                                                                  ],
                                                                ),
                                                              )
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    )
                  ],
                ),
                // loading liat booking
                CldV5.loadingBooking.value? Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(strokeWidth: 0.5,),
                      Text("load list booking")
                    ],
                  ),
                ): SizedBox.shrink()
              ],
            ),
          )
        ),
      ),
    );
  }
}

class ShowInfoBooking extends StatelessWidget {
  final ModelBooking booking;

  const ShowInfoBooking({Key key, this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) => 
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(booking.guestName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              Flexible(
                child: ListView(
                  controller: scrollController,
                  children: [
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CldV5 extends PhisCtrl{
  static final nameDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday"];
  static final nameMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "Oktober", "November", "Desember"];
  static final tahun = DateTime.now().year;

  static final loadingInit = false.obs;
  static final loadingRoomType = false.obs;
  static final loadingBooking = false.obs;

  static final lsRoomType = [].obs;
  static final lsBooking = <ModelBooking>[].obs;
  static final lsCalendar = <Calendar>[].obs;

  static final tanggalan = DateTime.now().obs;
  static final scrollController = TrackingScrollController().obs;

  static final prev = false.obs;
  static final next = false.obs;
  static final bulanController = PageController().obs;
  static final indexWeek = 0.obs;
  static final deltaDx = 0.0.obs;

  static init()async{
    loadingInit.value = true;
      final kal = await compute(getListCalendar, 0);
      lsCalendar.assignAll(kal);

      await getRoomType();
    loadingInit.value = false;

    Future.delayed(Duration(seconds: 2),()async{
      loadingBooking.value = true;
      final Response res = await ControllerApi.to.calendarBooking("$tahun-01-01", "$tahun-01-31");
      final List data = res.body['data']['data'];
      final lb = await compute(getListBooking, data);
      
      lsBooking.assignAll(lb);
      loadingBooking.value = false;
    });
    
  }

  static getRoomType()async{
    loadingRoomType.value = true;
    if(GetStorage().hasData("roomType")){
      lsRoomType.assignAll(GetStorage().read("roomType"));
      loadingRoomType.value = false;
    }

    final Response res = await ControllerApi.to.calendarRoomType();
    final data = res.body['data']['data'];
    lsRoomType.assignAll(data);
    loadingRoomType.value = false;
  }

  static getListBooking(List data)async{
    
    final compress = data.map((e) => 
      {
        "roomId": e['roomId'],
        "checkIn": e['checkIn'],
        "checkOut": e['checkOut'],
        "backgroundColor": e['backgroundColor'],
        "guestName": e['guestName'],
        "nationality": e['nationality'],
        "roomStatus": e['roomStatus'],
        "bookingSource": e['bookingSource'],
        "pax": e['pax'],
        "reservationNumber": e['reservationNumber'],
        "breakfast": e['breakfast'],
        "weekAwal": Calendar.indexWeek(e['checkIn']),
        "weekAkhir": Calendar.indexWeek(e['checkOut']),
        "tanggalAwal": DateTime.parse(e['checkIn']).day,
        "tanggalAkhir": DateTime.parse(e['checkOut']).day,
        "bulanAwal": DateTime.parse(e['checkIn']).month,
        "bulanAkhir": DateTime.parse(e['checkOut']).month,
        "tahunAwal": DateTime.parse(e['checkIn']).year,
        "tahunAkhir": DateTime.parse(e['checkOut']).year,
        "durasi": DateTimeRange(start: DateTime.parse(e['checkIn']), end: DateTime.parse(e['checkOut'])).duration.inDays + 1,
        "range": List.generate(DateTimeRange(start: DateTime.parse(e['checkIn']), end: DateTime.parse(e['checkOut'])).duration.inDays + 1, (index) => 
          {
            "tanggal": DateTime.parse(e['checkIn']).day + (index),
            "hari": DateTime(DateTime.parse(e['checkIn']).year, DateTime.parse(e['checkIn']).month, DateTime.parse(e['checkIn']).day + (index + 1)).weekday,
          }
        )
      }
    ).toList();
    List<ModelBooking> booking = compress.map((e) => ModelBooking.fromJson(e)).toList();
    return booking;
  }

  static Future getListCalendar(int i)async{
    final List<Calendar> ls = List.generate(12, (index) => Calendar(DateTime(tahun, index + 1, 1)));
    return ls;
  }

  static clickBooking(ModelBooking booking){
    Get.bottomSheet(ShowInfoBooking(booking: booking,));
  }
}

class Calendar {
  List perMonth;
  List perWeek;
  int year;
  int month;
  int day;
  int week;

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
          "week": i1 
         }: totalHari >= date ?
        { 
          "type": 1, 
          "date": date++,
          "week": i1 
        }: 
        { 
          "type": 2, 
          "date": i2++,
          "week": i1 
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

class ModelBooking {
  var roomId;
  var checkIn;
  var checkOut;
  var backgroundColor;
  var guestName;
  var weekAwal;
  var weekAkhir;
  var tanggalAwal;
  var tanggalAkhir;
  var bulanAwal;
  var bulanAkhir;
  var tahunAwal;
  var tahunAkhir;
  var durasi;
  var range;

  ModelBooking(
      {this.roomId,
      this.checkIn,
      this.checkOut,
      this.backgroundColor,
      this.guestName,
      this.weekAwal,
      this.weekAkhir,
      this.tanggalAwal,
      this.tanggalAkhir,
      this.bulanAwal,
      this.bulanAkhir,
      this.tahunAwal,
      this.tahunAkhir,
      this.durasi,
      this.range});

  ModelBooking.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    backgroundColor = json['backgroundColor'];
    guestName = json['guestName'];
    weekAwal = json['weekAwal'];
    weekAkhir = json['weekAkhir'];
    tanggalAwal = json['tanggalAwal'];
    tanggalAkhir = json['tanggalAkhir'];
    bulanAwal = json['bulanAwal'];
    bulanAkhir = json['bulanAkhir'];
    tahunAwal = json['tahunAwal'];
    tahunAkhir = json['tahunAkhir'];
    durasi = json['durasi'];
    range = json['range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['backgroundColor'] = this.backgroundColor;
    data['guestName'] = this.guestName;
    data['weekAwal'] = this.weekAwal;
    data['weekAkhir'] = this.weekAkhir;
    data['tanggalAwal'] = this.tanggalAwal;
    data['tanggalAkhir'] = this.tanggalAkhir;
    data['bulanAwal'] = this.bulanAwal;
    data['bulanAkhir'] = this.bulanAkhir;
    data['tahunAwal'] = this.tahunAwal;
    data['tahunAkhir'] = this.tahunAkhir;
    data['durasi'] = this.durasi;
    data['range'] = this.range;
    return data;
  }
}