import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class PercobaanCalendar extends StatelessWidget {
  final lebarPertama = 70.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: GetX(
            initState: (state) => PercobaanCtrl.init(),
            builder: (controller) => PercobaanCtrl.loading.value? Text("tunggu"):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Text(PercobaanCtrl.lsCalendar['tahun'].toString()),
                Text(PercobaanCtrl.lsCalendar['bulan'].toString()),
                Flexible(
                  child: PageView(
                    physics: ScrollPhysics(),
                    children: List.generate(PercobaanCtrl.lsCalendar['perpekan'].length, (i1) => 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: lebarPertama,
                                child: Text("date"),
                              ),
                              Expanded(
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  crossAxisCount: 7,
                                  children: List.generate(PercobaanCtrl.lsCalendar['perpekan'][i1].length, (i2) =>
                                    Center(
                                      child: Container(
                                        child: Text(PercobaanCtrl.lsCalendar['perpekan'][i1][i2]['tanggal'].toString()),
                                      ),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: ListView(
                              controller: PercobaanCtrl.tracking,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: List.generate(PercobaanCtrl.lsTypeRoom.length, (i3) => 
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: lebarPertama,
                                          child: Text("room"),
                                        ),
                                        Text(PercobaanCtrl.lsTypeRoom[i3]['nm_jenis'].toString()),
                                      ],
                                    ),
                                    Column(
                                      children: List.generate(PercobaanCtrl.lsTypeRoom[i3]['rooms'].length, (i4) => 
                                        Row(
                                          children: [
                                            Container(
                                              width: lebarPertama,
                                              child: Text(PercobaanCtrl.lsTypeRoom[i3]['rooms'][i4]['no_room'])
                                            ),
                                            Expanded(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                crossAxisCount: 7,
                                                children: List.generate(PercobaanCtrl.lsCalendar['perpekan'][i1].length, (i5) =>
                                                  PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'].map((ee) => ee['roomId']).toList().contains(PercobaanCtrl.lsTypeRoom[i3]['rooms'][i4]['no_room'])?
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: List.generate(PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'].length, (i6) => 
                                                      PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'][i6]['roomId'] == PercobaanCtrl.lsTypeRoom[i3]['rooms'][i4]['no_room']?
                                                      Expanded(
                                                        child: Listener(
                                                          onPointerDown: (event) => PercobaanCtrl.munculkanApi(PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'][i6]),
                                                          onPointerUp: (event) => Get.back(),
                                                          child: Container(
                                                            width: double.infinity,
                                                            color: Color(int.parse(PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'][i6]['warna'])),
                                                            child: Center(
                                                              child: Text(PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'][i6]['jenis'] == 0?PercobaanCtrl.lsCalendar['perpekan'][i1][i5]['events'][i6]['guestName']:"",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors.white54
                                                                ),
                                                                overflow: TextOverflow.fade,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ): SizedBox.shrink()
                                                    ),
                                                  ):
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.grey[200])
                                                    ),
                                                  )
                                                ),
                                              )
                                            )
                                          ],
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                            )
                          )
                        ],
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PercobaanCtrl extends PhisCtrl{
  static final lsCalendar = {}.obs;
  static final lsTypeRoom = [].obs;
  static final loading = false.obs;
  static final scrContrll = List.generate(7, (index) => ScrollController()).obs;
  static final tracking = TrackingScrollController();

  static init()async{

    scrContrll[0].addListener(() async{
      await GetStorage().write("scrl", scrContrll[0].offset);
    });
    

    loading.value = true;
    await initRoomType();
    await initListEvent();
    loading.value = false;
  }

  // init room type
  static initRoomType()async{
    try {
      final res = await ControllerApi.to.calendarRoomType();
      final data = res.body['data']['data'];
      lsTypeRoom.assignAll(data);
    } catch (e) {
      print(e);
    }
  }

  // init room list event
  static initListEvent()async{
    try {
      final res = await ControllerApi.to.calendarBooking("2021-01-01", "2021-01-31");
      final data = res.body['data']['data'];
      final olah = data.map( (e) => {
        "checkIn": e['checkIn'],
        "checkOut": e['checkOut'],
        "backgroundColor": e['backgroundColor'],
        "roomId": e['roomId'],
        "room_name": e['room_name'],
        "guestName": e['guestName'],
        "events": tanggalRange(e['checkIn'], e['checkOut'])
      }).toList();

      // sebulan(DateTime.parse("2021-01-01"), 1, olah);
      final a = await sebulan(DateTime.parse("2021-01-01"), 1, olah);
      lsCalendar.addAll(a);
    } catch (e) {
      print(e);
    }
  }

  static munculkanApi(var data){
    Get.dialog(SingleChildScrollView(child: Card(child: Text(JsonEncoder.withIndent("   ").convert(data).toString()),),));
  }

  static List tanggalRange(String checkIn, String checout) => List.generate(DateTime.parse(checout).difference(DateTime.parse(checkIn)).inDays + 1, (index) => {
    "tanggal": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).day,
    "bulan": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).month,
    "tahun": DateTime(DateTime.parse(checkIn).year, DateTime.parse(checkIn).month, DateTime.parse(checkIn).day + (index)).year,
    "jenis": DateTime.parse(checkIn).day == DateTime.parse(checkIn).day + index? 0: DateTime.parse(checout).day != DateTime.parse(checkIn).day + index? 1: 2
  }).toList();

  static sebulan(DateTime kal, int date, List lsEvent) async{

    final totalHari = DateTime(kal.year, kal.month + 1, 0).day;
    final Map hasil = {};
    final ls = List.generate(((kal.weekday + totalHari) / 7).ceil(), (i1) => 
      List.generate(7, (i2) => i1 == 0 && i2 < kal.weekday? 
        { 
          "type": 0,
          "tanggal": kal.subtract(Duration(days: kal.weekday)).day +i2,
          "events": []
         }: totalHari >= date ?
        { 
          "type": 1, 
          "tanggal": date++ , 
          "events": []
        }: 
        { 
          "type": 2, 
          "tanggal": i2++,
          "events": []
        }
      )
    );
    hasil['tanggalan'] = ls.expand((element) => element).toList();
    hasil['tahun'] = kal.year;
    hasil['bulan'] = kal.month;

    for(var i = 0; i < hasil['tanggalan'].length; i++){
      for(var x = 0; x < lsEvent.length; x++){
        for(var x1 = 0; x1 < lsEvent[x]['events'].length; x1++){
          if(
              hasil['tahun'] == lsEvent[x]['events'][x1]['tahun'] &&
              hasil['bulan'] == lsEvent[x]['events'][x1]['bulan'] &&
              hasil['tanggalan'][i]['tanggal'] == lsEvent[x]['events'][x1]['tanggal'] && 
              hasil['tanggalan'][i]['type'] == 1
            ){
            hasil['tanggalan'][i]['events'].add({
              "tanggal": lsEvent[x]['events'][x1]['tanggal'],
              "jenis": lsEvent[x]['events'][x1]['jenis'],
              "warna": lsEvent[x]['backgroundColor'].toString().replaceAll("#", "0xff"),
              "roomId": lsEvent[x]['roomId'].toString().trim(),
              "room_name": lsEvent[x]['room_name'].toString().trim(),
              "guestName": lsEvent[x]['guestName'].toString().trim(),
              "checkIn": lsEvent[x]['checkIn'].toString().trim(),
              "checkOut": lsEvent[x]['checkOut'].toString().trim(),
            });
            
          }
          // print([hasil['tanggalan'][i]['tanggal'],lsEvent[x]['events'][x1]['tanggal']]);
        }
      }
    }

    munculkanApi(hasil['tanggalan']);
    hasil['perpekan'] = hasil['tanggalan'].fold([[]], (list, x) => list.last.length == 7? (list..add([x])) : (list..last.add(x)));
    return hasil;
  }
}


