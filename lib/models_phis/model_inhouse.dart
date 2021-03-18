class ModelInHouse {
  dynamic noReservasi;
  dynamic tglBooking;
  dynamic namaTamu;
  dynamic room;
  dynamic hrgRoom;
  dynamic tglDatang;
  dynamic tglBerang;
  dynamic pax;
  dynamic pax2;
  dynamic lama;
  dynamic agen;
  dynamic nasional;
  dynamic stt;
  dynamic gsegmen;
  dynamic cmId;
  dynamic jenisKamar;
  dynamic totalHarga;
  dynamic guestsegmen;
  dynamic roomRate;
  dynamic nmMakan;
  dynamic totalDp;
  dynamic regStt;
  dynamic vip;
  dynamic nmCus;
  dynamic emailShow;
  bool res;
  List<String> reservasiDate;
  String customer;

  ModelInHouse(
      {this.noReservasi,
      this.tglBooking,
      this.namaTamu,
      this.room,
      this.hrgRoom,
      this.tglDatang,
      this.tglBerang,
      this.pax,
      this.pax2,
      this.lama,
      this.agen,
      this.nasional,
      this.stt,
      this.gsegmen,
      this.cmId,
      this.jenisKamar,
      this.totalHarga,
      this.guestsegmen,
      this.roomRate,
      this.nmMakan,
      this.totalDp,
      this.regStt,
      this.vip,
      this.nmCus,
      this.emailShow,
      this.res,
      this.reservasiDate,
      this.customer});

  ModelInHouse.fromJson(Map<String, dynamic> json) {
    noReservasi = json['no_reservasi'];
    tglBooking = json['tgl_booking'];
    namaTamu = json['nama_tamu'];
    room = json['room'];
    hrgRoom = json['hrg_room'];
    tglDatang = json['tgl_datang'];
    tglBerang = json['tgl_berang'];
    pax = json['pax'];
    pax2 = json['pax2'];
    lama = json['lama'];
    agen = json['agen'];
    nasional = json['nasional'];
    stt = json['stt'];
    gsegmen = json['gsegmen'];
    cmId = json['cm_id'];
    jenisKamar = json['jenis_kamar'];
    totalHarga = json['total_harga'];
    guestsegmen = json['guestsegmen'];
    roomRate = json['room_rate'];
    nmMakan = json['nm_makan'];
    totalDp = json['total_dp'];
    regStt = json['reg_stt'];
    vip = json['vip'];
    nmCus = json['nm_cus'];
    emailShow = json['email_show'];
    res = json['res'];
    reservasiDate = json['reservasi_date'].cast<String>();
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_reservasi'] = this.noReservasi;
    data['tgl_booking'] = this.tglBooking;
    data['nama_tamu'] = this.namaTamu;
    data['room'] = this.room;
    data['hrg_room'] = this.hrgRoom;
    data['tgl_datang'] = this.tglDatang;
    data['tgl_berang'] = this.tglBerang;
    data['pax'] = this.pax;
    data['pax2'] = this.pax2;
    data['lama'] = this.lama;
    data['agen'] = this.agen;
    data['nasional'] = this.nasional;
    data['stt'] = this.stt;
    data['gsegmen'] = this.gsegmen;
    data['cm_id'] = this.cmId;
    data['jenis_kamar'] = this.jenisKamar;
    data['total_harga'] = this.totalHarga;
    data['guestsegmen'] = this.guestsegmen;
    data['room_rate'] = this.roomRate;
    data['nm_makan'] = this.nmMakan;
    data['total_dp'] = this.totalDp;
    data['reg_stt'] = this.regStt;
    data['vip'] = this.vip;
    data['nm_cus'] = this.nmCus;
    data['email_show'] = this.emailShow;
    data['res'] = this.res;
    data['reservasi_date'] = this.reservasiDate;
    data['customer'] = this.customer;
    return data;
  }
}
