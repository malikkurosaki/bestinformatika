import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/component/pilih_bulan.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/log_ctrl.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class CalendarV3 extends StatelessWidget {
  final lebarSamping = 70.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: Obx( () =>
          Visibility(
            visible: CldrV3.muncul.value,
            child: FloatingActionButton(
              onPressed: () => CldrV3.lanjut.value?CldrV3.initnextMonth() : CldrV3.initPrevmonth(),
              child: Icon(
                CldrV3.lanjut.value?Icons.arrow_forward: Icons.arrow_back
              ),
            )
          )
        ),
        body: SafeArea(
          child: GetX(
            initState: (state) => CldrV3.init(),
            builder: (controller) => CldrV3.loading.value? 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Center(
                  child: Text(CldrV3.loadingText.value),
                )
              ],
            ): 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    BackButton(),
                    GestureDetector(
                      onTap: () => CldrV3.pilihBulan(),
                      child: Text("${CldrV3.calendar['tahun'].toString()} - ${CldrV3.calendar['bulan'].toString()}",
                        style: TextStyle(
                          fontSize: 24
                        ),
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
                    onPageChanged: (value) => CldrV3.onGantiHalaman(value),
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
                                      /// per rom
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
                                              // event calendar
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    for(var pekan in CldrV3.calendar['pekan'][i1])
                                                    Expanded(
                                                      flex: 1,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Colors.grey[300]
                                                              )
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 70,
                                                            child: Column(
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
                                                                      Transform.rotate(
                                                                        angle: 0.5,
                                                                        child: Card(
                                                                          child: Container(
                                                                            padding: EdgeInsets.all(4),
                                                                            child: Text(events['guestName'].toString(),
                                                                              overflow: TextOverflow.clip,
                                                                              style: TextStyle(
                                                                                fontSize: 12
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ),
                                                                      ):
                                                                      Icon(Icons.arrow_forward_ios,
                                                                        color: Colors.black26,
                                                                      )
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
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
  static final start = "2021-01-01";
  static final end = "2021-01-31";
  static final muncul = false.obs;
  static final tahun = 2021.obs;
  static final bulan = 1.obs;
  static final lanjut = false.obs;
  static final loadingText = "loading ...".obs;

  static init()async{
    loading.value = true;
    if(
      calendar.isNotEmpty &&
      lsRoomType.isNotEmpty &&
      lsBooking.isNotEmpty
    )
    {
      loadingText.value = "done";
      loading.value = false;
    }

    loadingText.value = "load room type ...";
    await initRoomType();
    loadingText.value = "load list booking ...";
    await initBooking(start, end);
    loadingText.value = "load room calendar ...";
    await calendarSebulan(DateTime(tahun.value, bulan.value));

    loading.value = false;
  }

  static initnextMonth()async{
    bulan.value ++;
    if(bulan.value > 12){
      bulan.value = 1;
      tahun.value ++;
    }

    loading.value = true;
    await initBooking(start, end);
    await calendarSebulan(DateTime(tahun.value, bulan.value));
    loading.value = false;
  }

  static initPrevmonth()async{
    bulan.value --;
    if(bulan.value < 1){
      bulan.value = 12;
      tahun.value --;
    }
    loading.value = true;
    await initBooking(start, end);
    await calendarSebulan(DateTime(tahun.value, bulan.value));
    loading.value = false;
  }

  static onGantiHalaman(int value){
    if(value == 0){
      muncul.value = true;
      lanjut.value = false;
    }
    else if(value == CldrV3.calendar['pekan'].length - 1){
      muncul.value = true;
      lanjut.value = true;
    }
    else{
      muncul.value = false;
    }
  }

  /// untuk memunculkan api setelah 
  /// 
  /// mendapatkannya dari fetch api
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


  /// load room type
  /// 
  /// - if data able from [GetStorage().hasData()] will assync [lsRoomType] from localStorage
  /// - able or not able data from [GetStorage().read("roomType")]
  static initRoomType()async{

    if(GetStorage().hasData("roomType")){
      lsRoomType.assignAll(GetStorage().read("roomType"));
    }

    List compress = [];
    try {
      final res = await ControllerApi.to.calendarRoomType();
      final data = res.body['data']['data'];

      compress = data.map( (e) => 
        {
          "kd_jenis": e['kd_jenis'],
          "nm_jenis": e['nm_jenis'],
          "rooms": List.generate(e['rooms'].length, (i) => 
            {
              "no_room": e['rooms'][i]['no_room'],
              "nama_room": e['rooms'][i]['nama_room']
            }
          )
        }
      ).toList();

    } catch (e) {
      /// if some error when fetch data from api, will write some log
      LogCtrl.add(e.toString());
      print(e);
      Get.snackbar("exattention", "failed to get data Room Type");
      compress = [];
    }

    /// jika hasil dari api tidak kosong 
    /// maka akan diteruskan ke layout 
    /// dan disimpan ke local untuk mempersingkat loading
    if(compress.isNotEmpty){
      lsRoomType.assignAll(compress);
      await GetStorage().write("roomType", compress);
    }
  }

  /// bottom sheet memilih bulan dan tahun
  static pilihBulan(){
    Get.bottomSheet(Pilihbulan());
  }

  /// feth data event [start] date time [end] date time 
  static initBooking(String start, String end)async{
    
    if(GetStorage().hasData("lsBooking")){
      lsBooking.assignAll(GetStorage().read("lsBooking"));
    }

    var compress = [];
    try {
      final res = await ControllerApi.to.calendarBooking(start, end);
      final data = res.body['data']['data'];
      compress = data.map( (e) => 
        {
          "roomId": e['roomId'],
          "room_name": e['room_name'],
          "guestName": e['guestName'],
          "checkIn": e['checkIn'],
          "checkOut": e['checkOut'],
          "backgroundColor": int.parse(e['backgroundColor'].toString().replaceAll("#", "0xff")),
          "range": rangeTanggal(e['checkIn'], e['checkOut'])
        }
      ).toList();
      
    } catch (e) {
      compress = [];
      print(e.toString());
      LogCtrl.add(e.toString());
    }


    if(compress.isNotEmpty){
      lsBooking.assignAll(compress);
      await GetStorage().write("lsBooking", compress);
    }

  }

  /// prosses range of date
  /// 
  /// [checkIn] and [checkOut] get from [lsBooking]
  static List rangeTanggal(String checkIn, String checout) => List.generate(DateTime.parse(checout).difference(DateTime.parse(checkIn)).inDays + 1, (index) => {
    "tanggal": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).day,
    "bulan": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).month,
    "tahun": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).year,
    "jenis": DateTime.parse(checkIn).day == DateTime.parse(checkIn).day + index? 0: DateTime.parse(checout).day != DateTime.parse(checkIn).day + index? 1: 2
  }).toList();

  /// mengolah bulan dalam sebulan
  /// 
  /// [kal] datetime 
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