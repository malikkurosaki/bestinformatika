
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class CalendarV4 extends StatelessWidget {
  final double tinggiNya = 44.0;
  final List halaman = [0];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: GetX(
          initState: (state) => CldV4.init(),
          builder: (controller) => CldV4.loading.value?Column(
            children: [
              BackButton(),
              Text("loading ..."),
            ],
          ):
          Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BackButton(),
                      Text("Calendar Booking",
                        style: TextStyle(
                          fontSize: 24
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(CldV4.tahun.value.toString(),
                          style: TextStyle(
                            fontSize: 24
                          ),
                        ),
                        Text(" - "),
                        Text(CldV4.nameMonths[CldV4.bulan.value - 1].toString(),
                          style: TextStyle(
                            fontSize: 24
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: PageView(
                      pageSnapping: true,
                      onPageChanged: (value) => CldV4.indexPage.value = value,
                      controller: CldV4.pageController.value,
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
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueGrey[600],
                                        child: Text((i1 + 1).toString())
                                      )
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        for(final tgl in CldV4.nameDays)
                                        Expanded(
                                          child: Center(
                                            child: Text(tgl.toString().substring(0, 3),
                                              style: TextStyle(
                                                color: tgl == "Sunday"? Colors.red : Colors.white,
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
                                                color: tgl['type'] == 1?Colors.white: Colors.white38,
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
                              child: OlahanSwipe(
                                maxIndex: CldV4.lsCalendar.length -1,
                                onKemana: (int kemana) async{ 
                                  // kekiri
                                  if(kemana == 0){
                                    if(CldV4.bulan.value <= 1) {
                                      CldV4.bulan.value = 12;
                                      CldV4.pageController.value.jumpToPage(CldV4.lsCalendar.length - 1);
                                      // CldV4.tahun.value --;
                                      print("mundur");
                                    }else{
                                      CldV4.bulan.value --;
                                    }
                                  }
                                  // kekanan
                                  else if(kemana == 1){
                                    if(CldV4.bulan.value >= 12) {
                                      CldV4.bulan.value = 1;
                                      CldV4.pageController.value.jumpToPage(0);
                                      // CldV4.tahun.value ++;
                                      print("maju");
                                    }else{
                                      CldV4.bulan.value ++;
                                    }
                                  }
                                },
                                pageIndex: CldV4.indexPage.value,
                                child: ListView(
                                  addAutomaticKeepAlives: true,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  controller: CldV4.controll,
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
                    ),
                  ),
                ],
              ),
              CldV4.loading2.value?
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 0.5,
                    ),
                    Text("load list booking ...")
                  ],
                ),
              ):SizedBox.shrink()
            ],
          )
        ),
      ),
    );
  }
}

class OlahanSwipe extends StatelessWidget {
  final Widget child;
  final int pageIndex;
  final int maxIndex;
  final Function(int kemana) onKemana;
  const OlahanSwipe({
    Key key, 
    @required this.child, 
    @required this.pageIndex, 
    @required this.maxIndex,
    @required this.onKemana
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int kananAtauKiri = 0;
    return Listener(
      onPointerMove: (event) {
        // cek kekanan
        if(event.delta.dx < -7){
          kananAtauKiri = 1;
        }
        // cek kekiri
        else if(event.delta.dx > 7){
          kananAtauKiri = 0;
        }
      },
      onPointerUp: (event) {
        // jika kekiri
        if(pageIndex == 0 && kananAtauKiri == 0){
          onKemana(0);
        }
        // jika kekanan
        else if(pageIndex == maxIndex && kananAtauKiri == 1){
          onKemana(1);
        }
      },
      child: child,
    );
  }
}

class CldV4 extends PhisCtrl{
  
  static final loading = false.obs;
  static final loading2 = false.obs;

  static final tahun = 0.obs;
  static final bulan = 0.obs;
  static final tanggal = 0.obs;

  static final lsCalendar = [].obs;
  static final lsRoom = [].obs;
  static final controll = TrackingScrollController();
  static final pageController = PageController().obs;
  static final indexPage = 0.obs;

  static final nameDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thrusday", "Friday", "Saturday"];
  static final nameMonths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "Oktober", "November", "Desember"];

  static init()async{
    final cal = DateTime.now();
    tahun.value = cal.year;
    bulan.value = cal.month;
    tanggal.value = cal.day;
    loading.value = true;
    await initCalendar();
    await initRoomType(tahun.value);
    loading.value = false;
  }

  static initCalendar()async {
    loading2.value = true;
    final Map cal = await Calendar.json(DateTime(tahun.value, bulan.value, tanggal.value));
    lsCalendar.assignAll(cal['perWeek']);
    loading2.value = false;
  }

  static initRoomType(int year)async{
    loading2.value = true;
    final start = DateTime(year, 01, 01);
    final end = DateTime(year, 12, 31);
    List compress = [];
    
    if(GetStorage().hasData("compress")){
      lsRoom.assignAll(GetStorage().read("compress"));
      loading.value = false;
    }

    try {
      final Response res = await ControllerApi.to.calendarRoomType();
      final Response resB = await ControllerApi.to.calendarBooking(start.toString(), end.toString());
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
      print(lsRoom);

    } catch (e) {
      print(e);
      compress = [];
    }
    loading2.value = false;
  }
}


/// # get index of week per month
/// 
/// calculate index list on a mont by datetime
/// divided by 7 , [7] is total day of week
/// [tahun] eg: "2021-01-01" 
/// result eg : 0,1,2,3,4
int minggu (String tahun){
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

/// calculate map of month
/// 
/// ['perMonth'] produce `[1,2,3..31]`
/// ['perWeek] produce `[[1,2,3 ..7], [8,9,10..14],[],[]]` 2 demintional array
/// ['year'] produce eg: '2021'
/// ['month'] produce eg: '02'
/// ['day'] produce eg: 01
/// ['week'] peoduce index of week eg: 0,1,2,3 ...
class Calendar {
  static json(DateTime dateTime)async{
    final k = dateTime;
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
