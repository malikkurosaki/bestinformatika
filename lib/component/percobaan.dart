
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class CalendarV4 extends StatelessWidget {
  final double tinggiNya = 44.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BackButton(),
            Flexible(
              child: GetX(
                initState: (state) => CldV4.init(),
                builder: (controller) => CldV4.loading.value?Text("loading ..."):
                PageView(
                  children: List.generate(CldV4.lsCalendar.length, (i1) => 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: tinggiNya,
                          color: Colors.blueGrey,
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    for(final tgl in CldV4.lsCalendar[i1])
                                    Expanded(
                                      child: Center(
                                        child: Text(tgl['date'].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      )
                                    )
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(final lsRm in CldV4.lsRoom)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Colors.blueGrey[600],
                                      padding: EdgeInsets.all(8),
                                      child: Text(lsRm['nm_jenis'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                        ),
                                      )
                                    ),
                                    // room nomer
                                    for(final room in lsRm['rooms'])
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                          ),
                                          width: Get.width / 8,
                                          height: tinggiNya,
                                          child: Center(
                                            child: Text(room['no_room'].toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        // tabel reservasi
                                        Expanded(
                                          child: Container(
                                            color: Colors.white,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      for(final tg in CldV4.lsCalendar[i1])
                                                      Expanded(
                                                        child: Container(
                                                          height: tinggiNya,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              width: 0.1,
                                                              color: Colors.blue
                                                            )
                                                          ),
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                 Container(
                                                  child: Row(
                                                    children: [
                                                      for(final tg in CldV4.lsCalendar[i1].map((m1) => {"date": m1['type'] == 1?m1['date']: 0}).toList())
                                                      Expanded(
                                                        child: Container(
                                                          height: tinggiNya,
                                                          child: Column(
                                                            children: [
                                                              for(final evn in room['events'])
                                                              evn['range'].map((ee) => ee['tanggal']).toList().contains(tg['date'])?
                                                              Flexible(
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Color(int.parse(evn['backgroundColor'].toString().replaceAll("#", "0xff"))),
                                                                  ),
                                                                  padding: EdgeInsets.all(8),
                                                                ),
                                                              )
                                                              : SizedBox.shrink()
                                                            ],
                                                          ),
                                                        )
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                for(final evn in room['events'])
                                                evn['week_awal'] == i1 || evn['week_akhir'] == i1? 
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      for(final tg in CldV4.lsCalendar[i1])
                                                      Expanded(
                                                        child: Container(
                                                          height: tinggiNya,
                                                          child: tg['date'] == evn['tanggal_awal']?
                                                          OverflowBox(
                                                            alignment: Alignment.bottomLeft,
                                                            maxWidth: Get.width,
                                                            maxHeight: tinggiNya,
                                                            child: Container(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Container(
                                                                width: (evn['range'].where((wr) => wr['week'] == i1).toList().length ) * (Get.width / 8),
                                                                padding: EdgeInsets.all(4),
                                                                child: Text(evn['guestName'],
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    backgroundColor: Colors.black54,
                                                                    fontSize: 12
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                )
                                                              ),
                                                            ),
                                                          )
                                                          : tg['date'] == evn['tanggal_akhir']?
                                                          OverflowBox(
                                                            alignment: Alignment.topRight,
                                                            maxWidth:  (evn['range'].where((wr) => wr['week'] == i1).toList().length ) * (Get.width / 8),
                                                            maxHeight: tinggiNya,
                                                            child: Align(
                                                              alignment: Alignment.topRight,
                                                              child: Container(
                                                                width: ((evn['range'].where((wr) => wr['week'] == i1).toList().length -1) == 0? evn['range'].where((wr) => wr['week'] == i1).toList().length : evn['range'].where((wr) => wr['week'] == i1).toList().length - 1)  * (Get.width / 8),
                                                                padding: EdgeInsets.all(4),
                                                                child: Text(evn['guestName'],
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    backgroundColor: Colors.black54,
                                                                    fontSize: 12
                                                                  ),
                                                                  textAlign: TextAlign.end,
                                                                  overflow: TextOverflow.ellipsis,
                                                                )
                                                              ),
                                                            ),
                                                          ):
                                                          SizedBox.shrink(),
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                )
                                                :SizedBox.shrink()
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}

class CldV4 extends PhisCtrl{
  static final lsCalendar = Calendar.json("2021-01-10")['perWeek'];
  static final loading = false.obs;
  static final lsRoom = [].obs;
  static final tanggalan = "2021-01-01";
  
  static init()async{
    
    loading.value = true;
    await initRoomType("2021-01-01", "2021-01-31");
    loading.value = false;
  }


  static initRoomType(String start, String end)async{
    List compress = [];
    if(GetStorage().hasData("compress")){
      lsRoom.assignAll(GetStorage().read("compress"));
      loading.value = false;
    }
    try {
      final Response res = await ControllerApi.to.calendarRoomType();
      final Response resB = await ControllerApi.to.calendarBooking(start, end);
      final List lrt = res.body['data']['data'];
      final List lbk = resB.body['data']['data'];

      compress = lrt.map( (e) => 
        {
          "kd_jenis": e['kd_jenis'],
          "nm_jenis": e['nm_jenis'],
          "rooms": List.generate(e['rooms'].length, (i) => 
            {
              "no_room": e['rooms'][i]['no_room'],
              "nama_room": e['rooms'][i]['nama_room'],
              "events": lbk.where((w1) => w1['roomId'] == e['rooms'][i]['no_room']).toList().map((e1) => 
                {
                  "checkIn": e1['checkIn'],
                  "checkOut": e1['checkOut'],
                  "guestName": e1['guestName'],
                  "room": e['rooms'][i]['no_room'],
                  "backgroundColor": e1['backgroundColor'],
                  "week_awal": minggu(e1['checkIn']),
                  "week_akhir": minggu(e1['checkOut']),
                  "tanggal_awal": DateTime.parse(e1['checkIn']).day,
                  "tanggal_akhir": DateTime.parse(e1['checkOut']).day,
                  "hari_awal": DateTime.parse(e1['checkIn']).weekday,
                  "durasi": DateTimeRange(start: DateTime.parse(e1['checkIn']), end: DateTime.parse(e1['checkOut'])).duration.inDays,
                  "range": List.generate(DateTimeRange(start: DateTime.parse(e1['checkIn']), end: DateTime.parse(e1['checkOut'])).duration.inDays + 1, (index) => 
                    {
                      "tanggal": DateTime.parse(e1['checkIn']).day + (index),
                      "hari": DateTime(DateTime.parse(e1['checkIn']).year, DateTime.parse(e1['checkIn']).month, DateTime.parse(e1['checkIn']).day + (index + 1)).weekday,
                      "week": minggu(DateTime(DateTime.parse(e1['checkIn']).year, DateTime.parse(e1['checkIn']).month, DateTime.parse(e1['checkIn']).day + (index)).toString())
                    }
                  )
                }
              ).toList(),
            }
          )
        }
      ).toList();

      if(lrt.isNotEmpty && lbk.isNotEmpty){
        await GetStorage().write("compress", compress);
      }
      lsRoom.assignAll(compress);
    } catch (e) {
      print(e);
      compress = [];
    }
    
  }
  
}

minggu (String tahun){
  final k = DateTime.parse(tahun);
  final kal = DateTime(k.year,k.month);
  final total = DateTime(kal.year, kal.month + 1, 0).day; 
  var date = 1;
  var week = [];
  var mg = 0;
  var hasil = 0;
  for(var i1 = 0; i1 < ((kal.weekday + total) / 7).ceil(); i1++){
    week.add([]);
    for(var i2 = 0; i2 < 7; i2++){
      if(i1 == 0 && i2 < kal.weekday){
       hasil = 0;
      }
      else if(total >= date){
        if(k.day == date){
          mg = i1;
        }
        hasil = date ++;
      }
      else{
        hasil = 0;
      }
      week[i1].add(hasil);
    }
    
  }
  return mg;
}


class Calendar {
  static json(String dateTime){
    final k = DateTime.parse(dateTime);
    final kal = DateTime(k.year, k.month);
    final totalHari = DateTime(kal.year, kal.month + 1, 0).day;
    final Map hasil = {};
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
    hasil['perMonth'] = ls.expand((element) => element).toList();
    hasil['perWeek'] = ls;
    hasil['year'] = kal.year;
    hasil['month'] = kal.month;
    hasil['day'] = kal.day;
    hasil['week'] = ls.map((e) => e.where((element) => element['type'] == 1 && element['date'] == kal.day).toList()).toList().expand((element) => element).toList()[0]['week'];
    return hasil;

  }
}
