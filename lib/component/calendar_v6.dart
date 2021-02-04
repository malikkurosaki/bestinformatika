import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class CalendarV6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: GetX(
            initState: (state) => CldV6.init(),
            builder: (controller) => CldV6.loadingInit.value? Text("loading"):
            Column(
              children: [
                BackButton(),
                Text("calendar booking ")
              ],
            ),
          )
        ),
      ),
    );
  }

  
}


class CldV6 extends PhisCtrl{
  static final lsCalendar = [].obs;
  static final loadingInit = false.obs;
  static final lsRoomType = [].obs;

  static init(){
    loadingInit.value = true;
      lsCalendar.assignAll(Calendar(DateTime.now()).setahun);

    loadingInit.value = false;
  }


  static getRoomType()async{
    if(GetStorage().hasData("roomType")){
      lsRoomType.assignAll(GetStorage().read("roomType"));
    }

    final Response res = await ControllerApi.to.calendarRoomType();
    final data = res.body['data']['data'];
    lsRoomType.assignAll(data);
  }
}


class Calendar {
  List perMonth;
  List perWeek;
  int year;
  int month;
  int day;
  int week;
  List setahun;

  Calendar(DateTime dateTime){
    //json(dateTime);
    this.setahun = List.generate(12, (index) => json(DateTime(dateTime.year, dateTime.month + (index), 1)));
  }

  json(DateTime dateTime){
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