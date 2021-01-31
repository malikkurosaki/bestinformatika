import 'dart:convert';

void main() {
  final tanggalan = DateTime(2021, 2, 10);

  final List ls = Percobaan.sebulan(2021, 4)['week'];
  final tanggal = 1;
  
  final lsMap = ls
      .map((e) => e
      .where((e) => e["type"] != 0 && e["type"] != 2)
      .toList()
      .map((e) => e['value'])
      .toList())
      .toList();
  final idx = lsMap
      .map((e) => e.indexOf(tanggal))
      .toList()
      .indexWhere((element) => element != -1);

  final index = ls[idx].indexWhere((e) => e['value'] == tanggal);

  final awal = 3;
  final akhir = 8;
  final range = List.generate((akhir + 1) - awal, (index) => awal + index);

  final List event = FakeData.response['data']['data'];
  final List roomType = FakeData.roomType['data']['data'];

  final jenisKamar = roomType
      .map((e) => {
            "nm_jenis": e['nm_jenis'],
            "rooms": e['rooms']
                .map((a) => {
                      "no_room": a['no_room'],
                      "room_name": a['nama_room'],
                      "event": event
                          .where((element) =>
                              element['room_name'].toString().toLowerCase() ==
                              a['nama_room'].toString().toLowerCase())
                          .toList()
                          .map((s) => {
                                "room_name": s['room_name'],
                                "checkIn": s['checkIn'],
                                "checkOut": s['checkOut'],
                                "guestName": s['guestName'],
                                "backgroundColor": s['backgroundColor'],
                                "range": Percobaan.getListRange(
                                    Percobaan.getTanggal(s['checkIn']),
                                    Percobaan.getTanggal(s['checkOut'])),
                                "tahun_awal": Percobaan.getTahun(s['checkIn']),
                                "tahun_akhir":
                                    Percobaan.getTahun(s['checkOut']),
                                "bulan_awal": Percobaan.getBulan(s['checkIn']),
                                "bulan_akhir":
                                    Percobaan.getBulan(s['checkOut']),
                                "tanggal_awal":
                                    Percobaan.getTanggal(s['checkIn']),
                                "tanggal_akhir":
                                    Percobaan.getTanggal(s['checkOut']),
                                "minggu_awal": Percobaan.getPekan(s['checkIn']),
                                "minggu_akhir":
                                    Percobaan.getPekan(s['checkOut'])
                              })
                          .toList()
                    })
                .toList()
          })
      .toList();

  final lsEvent = Percobaan.getEvent(
      FakeData.roomType['data']['data'], FakeData.response['data']['data']);
  final sebulan = Percobaan.sebulan(2020, 12);

  final List aya = Ini.hitung("2021-01-01");

  final itu = aya.fold(
      [[]],
      (list, x) =>
          list.last.length == 7 ? (list..add([x])) : (list..last.add(x)));
  //print(JsonEncoder.withIndent(" ").convert(itu));
  final myfiled = {"IDAufgaben": "2630", "Aufgabe": "erste Aufgabe"};
  print(JsonEncoder.withIndent(" ").convert(myfiled));
}

class Ini {
  static hitung(String kalender) {
    final tanggalan = DateTime.parse(kalender);
    final tahun = tanggalan.year;
    final bulan = tanggalan.month;
    final pekan = tanggalan.weekday;
    final totalHari = DateTime(tahun, bulan + 1, 0).day;

    var tanggal = 1;
    final hasil = [];

    for (var i = 0; i < ((pekan + totalHari) / 7).ceil(); i++) {
      var tmp = {};
      var awal = tanggalan.subtract(Duration(days: pekan)).day;
      var akhir = 1;
      for (var x = 0; x < 7; x++) {
        if (x == 0 && i < pekan) {
          tmp = {"type": 0, "value": awal++};
        } else if (totalHari >= tanggal) {
          tmp = {"type": 1, "value": tanggal};
          tanggal++;
        } else if (tanggal > totalHari) {
          tmp = {"type": 2, "value": akhir++};
        }
        hasil.add(tmp);
      }
    }
    return hasil;
  }
}

class Percobaan {
  static final setahun = List.generate(12, (index) => sebulan(2021, index + 1));

  static getListRange(int awal, int akhir) {
    return List.generate((akhir + 1) - awal, (index) => awal + index)
        .map((e) => {
              "jenis": e == awal
                  ? 0
                  : e != awal && e != akhir
                      ? 1
                      : 2,
              "value": e
            })
        .toList();
  }

  // mendapatkan tahun
  static getTahun(String calendar) => DateTime.parse(calendar).year;
  // mendapatkakn bulan
  static getBulan(String calendar) => DateTime.parse(calendar).month;
  // mendapatkan tanggal bulan target
  static getTanggal(String calendar) => DateTime.parse(calendar).day;
  // mendapatkan index sepekan mbulan target
  static getPekan(String calendar) {
    final cld = DateTime.parse(calendar);
    final lsCalendar = sebulan(cld.year, cld.month)['week'];
    final lsMap = lsCalendar
        .map((e) => e
            .where((e) => e["type"] != 0 && e["type"] != 2)
            .toList()
            .map((e) => e['value'])
            .toList())
        .toList();
    final idx = lsMap
        .map((e) => e.indexOf(cld.day))
        .toList()
        .indexWhere((element) => element != -1);
    return idx;
  }

  static getTotalHari(String calendar) => DateTime(
          DateTime.parse(calendar).year, DateTime.parse(calendar).month + 1, 0)
      .day;

  static getTotalPekan(String calendar) {
    final cal = DateTime.parse(calendar);
    final pkn = cal.weekday;
    return ((pkn + getTotalHari(calendar)) / 7).ceil();
  }

  static getEvent(List roomType, List event) {
    final eventKamar = roomType
        .map((e) => {
              "nm_jenis": e['nm_jenis'],
              "rooms": e['rooms']
                  .map((a) => {
                        "no_room": a['no_room'],
                        "room_name": a['nama_room'],
                        "events": event
                            .where((element) =>
                                element['room_name'].toString().toLowerCase() ==
                                a['nama_room'].toString().toLowerCase())
                            .toList()
                            .map((s) => {
                                  "room_name": s['room_name'],
                                  "checkIn": s['checkIn'],
                                  "checkOut": s['checkOut'],
                                  "guestName": s['guestName'],
                                  "backgroundColor": s['backgroundColor'],
                                  "range": getListRange(
                                      getTanggal(s['checkIn']),
                                      getTanggal(s['checkOut'])),
                                  "tahun_awal": getTahun(s['checkIn']),
                                  "tahun_akhir": getTahun(s['checkOut']),
                                  "bulan_awal": getBulan(s['checkIn']),
                                  "bulan_akhir": getBulan(s['checkOut']),
                                  "tanggal_awal": getTanggal(s['checkIn']),
                                  "tanggal_akhir": getTanggal(s['checkOut']),
                                  "minggu_awal": getPekan(s['checkIn']),
                                  "minggu_akhir": getPekan(s['checkOut']),
                                  "total_hari_awal": getTotalHari(s['checkIn']),
                                  "total_hari_akhir":
                                      getTotalHari(s['checkOut']),
                                  "total_pekan_awal":
                                      getTotalPekan(s['checkIn']),
                                  "total_pekan_akhir":
                                      getTotalPekan(s['checkOut']),
                                })
                            .toList()
                      })
                  .toList()
            })
        .toList();

    return eventKamar;
  }

  static Map sebulan(int tahun, int bulan) {
    final tanggal = DateTime(tahun, bulan);
    final minggu = tanggal.weekday;
    final totalHari = DateTime(tahun, bulan + 1, 0).day;

    var date = 1;
    var bulanan = {};
    bulanan['month'] = bulan;
    bulanan['week'] = [];
    bulanan['day'] = [];
    for (var j = 0; j < ((minggu + totalHari) / 7).ceil(); j++) {
      bulanan['week'].add([]);
      int awal = tanggal.subtract(Duration(days: tanggal.weekday)).day;
      int akhir = 1;
      for (var i = 0; i < 7; i++) {
        var isi = {};
        if (j == 0 && i < minggu) {
          isi = {"type": 0, "value": awal++};
        } else if (totalHari >= date) {
          isi = {"type": 1, "value": date};
          date++;
        } else if (date > totalHari) {
          isi = {"type": 0, "value": akhir++};
        }
        bulanan['day'].add(isi);
        bulanan['week'][j].add(isi);
      }
    }
    return bulanan;
  }
}

class FakeData {
  static final Map roomType = {
    "response": 200,
    "message": "Room Type List",
    "status": true,
    "param": {"outlet": "1"},
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

  static final Map response = {
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
          "checkIn": "2020-12-23",
          "checkOut": "2020-12-24",
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
            "alamat":
                "                                                                                                    ",
            "tgl_aktif": "0000-00-00",
            "coa_piut": "",
            "telpon": "",
            "hp": "",
            "fax": "                    ",
            "ket":
                "                                                                                                    ",
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
          "checkIn": "2020-12-25",
          "checkOut": "2020-12-26",
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
          "reservasiDatePrice": {"2020-12-25": "0.00", "2020-12-26": "0.00"}
        },
        {
          "id": "RES/2012/SQSYA",
          "roomId": "103",
          "room_name": "103 ONE BEDROOM VILLA",
          "dummy": 0,
          "checkIn": "2020-12-25",
          "checkOut": "2020-12-26",
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
          "reservasiDatePrice": {"2020-12-25": "0.00", "2020-12-26": "0.00"}
        },
        {
          "id": "RES/2012/Y0YFR",
          "roomId": "115",
          "room_name": "111 TWO BEDROOM",
          "dummy": 0,
          "checkIn": "2020-12-25",
          "checkOut": "2020-12-28",
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
          "checkIn": "2020-12-25",
          "checkOut": "2020-12-26",
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
            "alamat":
                "                                                                                                    ",
            "tgl_aktif": "0000-00-00",
            "coa_piut": "",
            "telpon": "",
            "hp": "",
            "fax": "                    ",
            "ket":
                "                                                                                                    ",
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
