class ModelRoomType {
  String kdJenis;
  String nmJenis;
  String idCm;
  List<Rooms> rooms;

  ModelRoomType({this.kdJenis, this.nmJenis, this.idCm, this.rooms});

  ModelRoomType.fromJson(Map<String, dynamic> json) {
    kdJenis = json['kd_jenis'];
    nmJenis = json['nm_jenis'];
    idCm = json['id_cm'];
    if (json['rooms'] != null) {
      rooms = new List<Rooms>();
      json['rooms'].forEach((v) {
        rooms.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_jenis'] = this.kdJenis;
    data['nm_jenis'] = this.nmJenis;
    data['id_cm'] = this.idCm;
    if (this.rooms != null) {
      data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String noRoom;
  String namaRoom;
  String jenis;
  String urut;
  String nmJenis;
  String available;
  int dummy;
  String backpack;
  String villa;
  String katagori;
  String hotel;
  String meeting;
  String meetingc;
  String nonOta;
  String unlocated;
  int price;
  String maskprice;
  int bookeepingrate;
  String breakfast;
  String extranom;
  int total;
  int lama;
  int children;
  int extra;

  Rooms(
      {this.noRoom,
      this.namaRoom,
      this.jenis,
      this.urut,
      this.nmJenis,
      this.available,
      this.dummy,
      this.backpack,
      this.villa,
      this.katagori,
      this.hotel,
      this.meeting,
      this.meetingc,
      this.nonOta,
      this.unlocated,
      this.price,
      this.maskprice,
      this.bookeepingrate,
      this.breakfast,
      this.extranom,
      this.total,
      this.lama,
      this.children,
      this.extra});

  Rooms.fromJson(Map<String, dynamic> json) {
    noRoom = json['no_room'];
    namaRoom = json['nama_room'];
    jenis = json['jenis'];
    urut = json['urut'];
    nmJenis = json['nm_jenis'];
    available = json['available'];
    dummy = json['dummy'];
    backpack = json['backpack'];
    villa = json['villa'];
    katagori = json['katagori'];
    hotel = json['hotel'];
    meeting = json['meeting'];
    meetingc = json['meetingc'];
    nonOta = json['non_ota'];
    unlocated = json['unlocated'];
    price = json['price'];
    maskprice = json['maskprice'];
    bookeepingrate = json['bookeepingrate'];
    breakfast = json['breakfast'];
    extranom = json['extranom'];
    total = json['total'];
    lama = json['lama'];
    children = json['children'];
    extra = json['extra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_room'] = this.noRoom;
    data['nama_room'] = this.namaRoom;
    data['jenis'] = this.jenis;
    data['urut'] = this.urut;
    data['nm_jenis'] = this.nmJenis;
    data['available'] = this.available;
    data['dummy'] = this.dummy;
    data['backpack'] = this.backpack;
    data['villa'] = this.villa;
    data['katagori'] = this.katagori;
    data['hotel'] = this.hotel;
    data['meeting'] = this.meeting;
    data['meetingc'] = this.meetingc;
    data['non_ota'] = this.nonOta;
    data['unlocated'] = this.unlocated;
    data['price'] = this.price;
    data['maskprice'] = this.maskprice;
    data['bookeepingrate'] = this.bookeepingrate;
    data['breakfast'] = this.breakfast;
    data['extranom'] = this.extranom;
    data['total'] = this.total;
    data['lama'] = this.lama;
    data['children'] = this.children;
    data['extra'] = this.extra;
    return data;
  }
}
