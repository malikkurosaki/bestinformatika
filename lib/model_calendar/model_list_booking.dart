class ModelListBooking {
  String id;
  String roomId;
  String roomName;
  int dummy;
  String checkIn;
  String checkOut;
  String guestId;
  String guestName;
  String reservationNumber;
  String registrationNumber;
  String nationality;
  String roomStatus;
  String backgroundColor;
  String fontColor;
  String adult;
  String child;
  String currency;
  int bookeepingRate;
  String roomRate;
  int deposit;
  String bookingSource;
  Agent agent;
  String memo;
  int roomDestinationId;
  String bookingType;
  String breakfast;
  String jenisRoom;
  String price;
  String source;
  String formatPrice;
  String noRes;
  String namaTamu;
  String noRoom;
  String pax;
  TglDatang tglDatang;
  TglDatang tglBerang;
  String hrgRoom;
  String jenis;
  String kdAgen;
  String email;
  String rate;
  String nasional;
  String editKet;
  String editNom;
  String user;
  String nmMakan;
  String hrgMakan;
  String gsegment;
  String ginfo;
  String telpon;
  String kdTamu;
  String namaGroup;
  String paxFreebf;
  String country;
  String noHp;
  String vip;
  String titleTamu;
  String regStt;
  String status;
  String phoneCode;
  String previewPrice;
  String totalPrice;
  String voucherId;
  String noCm;
  bool statusData;
  String stt;
  String noRef;
  String otaCountry;
  TglDatang bookedDate;
  String statusBooking;
  String lastUser;
  String userm;
  String lama;
  List<ReservasiDateData> reservasiDateData;
  List<String> depositDetail;
  String res;

  ModelListBooking(
      {this.id,
      this.roomId,
      this.roomName,
      this.dummy,
      this.checkIn,
      this.checkOut,
      this.guestId,
      this.guestName,
      this.reservationNumber,
      this.registrationNumber,
      this.nationality,
      this.roomStatus,
      this.backgroundColor,
      this.fontColor,
      this.adult,
      this.child,
      this.currency,
      this.bookeepingRate,
      this.roomRate,
      this.deposit,
      this.bookingSource,
      this.agent,
      this.memo,
      this.roomDestinationId,
      this.bookingType,
      this.breakfast,
      this.jenisRoom,
      this.price,
      this.source,
      this.formatPrice,
      this.noRes,
      this.namaTamu,
      this.noRoom,
      this.pax,
      this.tglDatang,
      this.tglBerang,
      this.hrgRoom,
      this.jenis,
      this.kdAgen,
      this.email,
      this.rate,
      this.nasional,
      this.editKet,
      this.editNom,
      this.user,
      this.nmMakan,
      this.hrgMakan,
      this.gsegment,
      this.ginfo,
      this.telpon,
      this.kdTamu,
      this.namaGroup,
      this.paxFreebf,
      this.country,
      this.noHp,
      this.vip,
      this.titleTamu,
      this.regStt,
      this.status,
      this.phoneCode,
      this.previewPrice,
      this.totalPrice,
      this.voucherId,
      this.noCm,
      this.statusData,
      this.stt,
      this.noRef,
      this.otaCountry,
      this.bookedDate,
      this.statusBooking,
      this.lastUser,
      this.userm,
      this.lama,
      this.reservasiDateData,
      this.depositDetail,
      this.res});

  ModelListBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['roomId'];
    roomName = json['room_name'];
    dummy = json['dummy'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    guestId = json['guestId'];
    guestName = json['guestName'];
    reservationNumber = json['reservationNumber'];
    registrationNumber = json['registrationNumber'];
    nationality = json['nationality'];
    roomStatus = json['roomStatus'];
    backgroundColor = json['backgroundColor'];
    fontColor = json['fontColor'];
    adult = json['adult'];
    child = json['child'];
    currency = json['currency'];
    bookeepingRate = json['bookeepingRate'];
    roomRate = json['roomRate'];
    deposit = json['deposit'];
    bookingSource = json['bookingSource'];
    agent = json['agent'] == null ? null: json['agent'] == ""? new Agent(): new Agent.fromJson(json['agent']);
    memo = json['memo'];
    roomDestinationId = json['roomDestinationId'];
    bookingType = json['bookingType'];
    breakfast = json['breakfast'];
    jenisRoom = json['jenis_room'];
    price = json['price'];
    source = json['source'];
    formatPrice = json['formatPrice'];
    noRes = json['no_res'];
    namaTamu = json['nama_tamu'];
    noRoom = json['no_room'];
    pax = json['pax'];
    tglDatang = json['tgl_datang'] != null
        ? new TglDatang.fromJson(json['tgl_datang'])
        : null;
    tglBerang = json['tgl_berang'] != null
        ? new TglDatang.fromJson(json['tgl_berang'])
        : null;
    hrgRoom = json['hrg_room'];
    jenis = json['jenis'];
    kdAgen = json['kd_agen'];
    email = json['email'];
    rate = json['rate'];
    nasional = json['nasional'];
    editKet = json['edit_ket'];
    editNom = json['edit_nom'];
    user = json['user'];
    nmMakan = json['nm_makan'];
    hrgMakan = json['hrg_makan'];
    gsegment = json['gsegment'];
    ginfo = json['ginfo'];
    telpon = json['telpon'];
    kdTamu = json['kd_tamu'];
    namaGroup = json['nama_group'];
    paxFreebf = json['pax_freebf'];
    country = json['country'];
    noHp = json['no_hp'];
    vip = json['vip'];
    titleTamu = json['titleTamu'];
    regStt = json['reg_stt'];
    status = json['status'];
    phoneCode = json['phoneCode'];
    previewPrice = json['previewPrice'];
    totalPrice = json['totalPrice'];
    voucherId = json['voucher_id'];
    noCm = json['no_cm'];
    statusData = json['statusData'];
    stt = json['stt'];
    noRef = json['no_ref'];
    otaCountry = json['ota_country'];
    bookedDate = json['bookedDate'] != null
        ? new TglDatang.fromJson(json['bookedDate'])
        : null;
    statusBooking = json['statusBooking'];
    lastUser = json['lastUser'];
    userm = json['userm'];
    lama = json['lama'];
    if (json['reservasiDateData'] != null) {
      reservasiDateData = new List<ReservasiDateData>();
      json['reservasiDateData'].forEach((v) {
        reservasiDateData.add(new ReservasiDateData.fromJson(v));
      });
    }
    depositDetail = json['depositDetail'].cast<String>();
    res = json['res'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomId'] = this.roomId;
    data['room_name'] = this.roomName;
    data['dummy'] = this.dummy;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['guestId'] = this.guestId;
    data['guestName'] = this.guestName;
    data['reservationNumber'] = this.reservationNumber;
    data['registrationNumber'] = this.registrationNumber;
    data['nationality'] = this.nationality;
    data['roomStatus'] = this.roomStatus;
    data['backgroundColor'] = this.backgroundColor;
    data['fontColor'] = this.fontColor;
    data['adult'] = this.adult;
    data['child'] = this.child;
    data['currency'] = this.currency;
    data['bookeepingRate'] = this.bookeepingRate;
    data['roomRate'] = this.roomRate;
    data['deposit'] = this.deposit;
    data['bookingSource'] = this.bookingSource;
    if (this.agent != null) {
      data['agent'] = this.agent.toJson();
    }
    data['memo'] = this.memo;
    data['roomDestinationId'] = this.roomDestinationId;
    data['bookingType'] = this.bookingType;
    data['breakfast'] = this.breakfast;
    data['jenis_room'] = this.jenisRoom;
    data['price'] = this.price;
    data['source'] = this.source;
    data['formatPrice'] = this.formatPrice;
    data['no_res'] = this.noRes;
    data['nama_tamu'] = this.namaTamu;
    data['no_room'] = this.noRoom;
    data['pax'] = this.pax;
    if (this.tglDatang != null) {
      data['tgl_datang'] = this.tglDatang.toJson();
    }
    if (this.tglBerang != null) {
      data['tgl_berang'] = this.tglBerang.toJson();
    }
    data['hrg_room'] = this.hrgRoom;
    data['jenis'] = this.jenis;
    data['kd_agen'] = this.kdAgen;
    data['email'] = this.email;
    data['rate'] = this.rate;
    data['nasional'] = this.nasional;
    data['edit_ket'] = this.editKet;
    data['edit_nom'] = this.editNom;
    data['user'] = this.user;
    data['nm_makan'] = this.nmMakan;
    data['hrg_makan'] = this.hrgMakan;
    data['gsegment'] = this.gsegment;
    data['ginfo'] = this.ginfo;
    data['telpon'] = this.telpon;
    data['kd_tamu'] = this.kdTamu;
    data['nama_group'] = this.namaGroup;
    data['pax_freebf'] = this.paxFreebf;
    data['country'] = this.country;
    data['no_hp'] = this.noHp;
    data['vip'] = this.vip;
    data['titleTamu'] = this.titleTamu;
    data['reg_stt'] = this.regStt;
    data['status'] = this.status;
    data['phoneCode'] = this.phoneCode;
    data['previewPrice'] = this.previewPrice;
    data['totalPrice'] = this.totalPrice;
    data['voucher_id'] = this.voucherId;
    data['no_cm'] = this.noCm;
    data['statusData'] = this.statusData;
    data['stt'] = this.stt;
    data['no_ref'] = this.noRef;
    data['ota_country'] = this.otaCountry;
    if (this.bookedDate != null) {
      data['bookedDate'] = this.bookedDate.toJson();
    }
    data['statusBooking'] = this.statusBooking;
    data['lastUser'] = this.lastUser;
    data['userm'] = this.userm;
    data['lama'] = this.lama;
    if (this.reservasiDateData != null) {
      data['reservasiDateData'] =
          this.reservasiDateData.map((v) => v.toJson()).toList();
    }
    data['depositDetail'] = this.depositDetail;
    data['res'] = this.res;
    return data;
  }
}

class Agent {
  String kdCus;
  String lastName;
  String firstName;
  String gt;
  String saldoAr;
  String nmCus;
  String kdAgen;
  String namaAgen;
  String alamat;
  String tglAktif;
  String coaPiut;
  String telpon;
  String hp;
  String fax;
  String ket;
  String coaAr;
  String nama;
  String email;
  String kat;
  String contact;
  String ndiskon;
  int aKTIF;
  String discStt;
  String jnsLimit;
  String limitAr;
  int dISKON;
  String nMJENIS;
  String komisiSen;
  String sttKomisi;
  String ota;
  String paidKomisi;
  String komisi2;
  String apKomsen;
  String sttTax;
  String nasional;
  String idMember;
  int sttValid;
  String validDate;
  String cdept;
  String noId;
  int klm;
  String tglLahir;
  String nodisc;
  String discAlcohol;
  String discHa;
  String pinCus;
  String totPoin;
  String discSpa;
  String repeater;
  String ratecode;
  String cmCus;
  String discHf;
  String discHb;
  String discHo;
  String discHs;
  String dob;
  String pob;
  String gender;
  String nasionality;
  String blacklist;
  String pcId;
  String tcpId;
  String loginId;
  String dbupdate;
  String ar;
  String discFood;
  String diSCBVR;
  String discSisha;
  String diSCOTH;
  String diSCSHISHA;
  String groupCus;
  String inputKom;
  String inputAp;
  String logo;
  String joiner;
  String groups;
  String taxser;
  String comCm;
  String birthday;
  int age;
  String emailShow;

  Agent(
      {this.kdCus,
      this.lastName,
      this.firstName,
      this.gt,
      this.saldoAr,
      this.nmCus,
      this.kdAgen,
      this.namaAgen,
      this.alamat,
      this.tglAktif,
      this.coaPiut,
      this.telpon,
      this.hp,
      this.fax,
      this.ket,
      this.coaAr,
      this.nama,
      this.email,
      this.kat,
      this.contact,
      this.ndiskon,
      this.aKTIF,
      this.discStt,
      this.jnsLimit,
      this.limitAr,
      this.dISKON,
      this.nMJENIS,
      this.komisiSen,
      this.sttKomisi,
      this.ota,
      this.paidKomisi,
      this.komisi2,
      this.apKomsen,
      this.sttTax,
      this.nasional,
      this.idMember,
      this.sttValid,
      this.validDate,
      this.cdept,
      this.noId,
      this.klm,
      this.tglLahir,
      this.nodisc,
      this.discAlcohol,
      this.discHa,
      this.pinCus,
      this.totPoin,
      this.discSpa,
      this.repeater,
      this.ratecode,
      this.cmCus,
      this.discHf,
      this.discHb,
      this.discHo,
      this.discHs,
      this.dob,
      this.pob,
      this.gender,
      this.nasionality,
      this.blacklist,
      this.pcId,
      this.tcpId,
      this.loginId,
      this.dbupdate,
      this.ar,
      this.discFood,
      this.diSCBVR,
      this.discSisha,
      this.diSCOTH,
      this.diSCSHISHA,
      this.groupCus,
      this.inputKom,
      this.inputAp,
      this.logo,
      this.joiner,
      this.groups,
      this.taxser,
      this.comCm,
      this.birthday,
      this.age,
      this.emailShow});

  Agent.fromJson(Map<String, dynamic> json) {
    kdCus = json['kd_cus'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    gt = json['gt'];
    saldoAr = json['saldo_ar'];
    nmCus = json['nm_cus'];
    kdAgen = json['kd_agen'];
    namaAgen = json['nama_agen'];
    alamat = json['alamat'];
    tglAktif = json['tgl_aktif'];
    coaPiut = json['coa_piut'];
    telpon = json['telpon'];
    hp = json['hp'];
    fax = json['fax'];
    ket = json['ket'];
    coaAr = json['coa_ar'];
    nama = json['nama'];
    email = json['email'];
    kat = json['kat'];
    contact = json['contact'];
    ndiskon = json['ndiskon'];
    aKTIF = json['AKTIF'];
    discStt = json['disc_stt'];
    jnsLimit = json['jns_limit'];
    limitAr = json['limit_ar'];
    dISKON = json['DISKON'];
    nMJENIS = json['NM_JENIS'];
    komisiSen = json['komisi_sen'];
    sttKomisi = json['stt_komisi'];
    ota = json['ota'];
    paidKomisi = json['paid_komisi'];
    komisi2 = json['komisi2'];
    apKomsen = json['ap_komsen'];
    sttTax = json['stt_tax'];
    nasional = json['nasional'];
    idMember = json['id_member'];
    sttValid = json['stt_valid'];
    validDate = json['valid_date'];
    cdept = json['cdept'];
    noId = json['no_id'];
    klm = json['klm'];
    tglLahir = json['tgl_lahir'];
    nodisc = json['nodisc'];
    discAlcohol = json['disc_alcohol'];
    discHa = json['disc_ha'];
    pinCus = json['pin_cus'];
    totPoin = json['tot_poin'];
    discSpa = json['disc_spa'];
    repeater = json['repeater'];
    ratecode = json['ratecode'];
    cmCus = json['cm_cus'];
    discHf = json['disc_hf'];
    discHb = json['disc_hb'];
    discHo = json['disc_ho'];
    discHs = json['disc_hs'];
    dob = json['dob'];
    pob = json['pob'];
    gender = json['gender'];
    nasionality = json['nasionality'];
    blacklist = json['blacklist'];
    pcId = json['pc_id'];
    tcpId = json['tcp_id'];
    loginId = json['login_id'];
    dbupdate = json['dbupdate'];
    ar = json['ar'];
    discFood = json['disc_food'];
    diSCBVR = json['diSC_BVR'];
    discSisha = json['disc_sisha'];
    diSCOTH = json['diSC_OTH'];
    diSCSHISHA = json['diSC_SHISHA'];
    groupCus = json['group_cus'];
    inputKom = json['input_kom'];
    inputAp = json['input_ap'];
    logo = json['logo'];
    joiner = json['joiner'];
    groups = json['groups'];
    taxser = json['taxser'];
    comCm = json['com_cm'];
    birthday = json['birthday'];
    age = json['age'];
    emailShow = json['email_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_cus'] = this.kdCus;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['gt'] = this.gt;
    data['saldo_ar'] = this.saldoAr;
    data['nm_cus'] = this.nmCus;
    data['kd_agen'] = this.kdAgen;
    data['nama_agen'] = this.namaAgen;
    data['alamat'] = this.alamat;
    data['tgl_aktif'] = this.tglAktif;
    data['coa_piut'] = this.coaPiut;
    data['telpon'] = this.telpon;
    data['hp'] = this.hp;
    data['fax'] = this.fax;
    data['ket'] = this.ket;
    data['coa_ar'] = this.coaAr;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['kat'] = this.kat;
    data['contact'] = this.contact;
    data['ndiskon'] = this.ndiskon;
    data['AKTIF'] = this.aKTIF;
    data['disc_stt'] = this.discStt;
    data['jns_limit'] = this.jnsLimit;
    data['limit_ar'] = this.limitAr;
    data['DISKON'] = this.dISKON;
    data['NM_JENIS'] = this.nMJENIS;
    data['komisi_sen'] = this.komisiSen;
    data['stt_komisi'] = this.sttKomisi;
    data['ota'] = this.ota;
    data['paid_komisi'] = this.paidKomisi;
    data['komisi2'] = this.komisi2;
    data['ap_komsen'] = this.apKomsen;
    data['stt_tax'] = this.sttTax;
    data['nasional'] = this.nasional;
    data['id_member'] = this.idMember;
    data['stt_valid'] = this.sttValid;
    data['valid_date'] = this.validDate;
    data['cdept'] = this.cdept;
    data['no_id'] = this.noId;
    data['klm'] = this.klm;
    data['tgl_lahir'] = this.tglLahir;
    data['nodisc'] = this.nodisc;
    data['disc_alcohol'] = this.discAlcohol;
    data['disc_ha'] = this.discHa;
    data['pin_cus'] = this.pinCus;
    data['tot_poin'] = this.totPoin;
    data['disc_spa'] = this.discSpa;
    data['repeater'] = this.repeater;
    data['ratecode'] = this.ratecode;
    data['cm_cus'] = this.cmCus;
    data['disc_hf'] = this.discHf;
    data['disc_hb'] = this.discHb;
    data['disc_ho'] = this.discHo;
    data['disc_hs'] = this.discHs;
    data['dob'] = this.dob;
    data['pob'] = this.pob;
    data['gender'] = this.gender;
    data['nasionality'] = this.nasionality;
    data['blacklist'] = this.blacklist;
    data['pc_id'] = this.pcId;
    data['tcp_id'] = this.tcpId;
    data['login_id'] = this.loginId;
    data['dbupdate'] = this.dbupdate;
    data['ar'] = this.ar;
    data['disc_food'] = this.discFood;
    data['diSC_BVR'] = this.diSCBVR;
    data['disc_sisha'] = this.discSisha;
    data['diSC_OTH'] = this.diSCOTH;
    data['diSC_SHISHA'] = this.diSCSHISHA;
    data['group_cus'] = this.groupCus;
    data['input_kom'] = this.inputKom;
    data['input_ap'] = this.inputAp;
    data['logo'] = this.logo;
    data['joiner'] = this.joiner;
    data['groups'] = this.groups;
    data['taxser'] = this.taxser;
    data['com_cm'] = this.comCm;
    data['birthday'] = this.birthday;
    data['age'] = this.age;
    data['email_show'] = this.emailShow;
    return data;
  }
}

class TglDatang {
  String date;
  int timezoneType;
  String timezone;

  TglDatang({this.date, this.timezoneType, this.timezone});

  TglDatang.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class ReservasiDateData {
  String noRef;
  String noRes;
  String noRoom;
  String rdate;
  String typebook;
  String typeday;
  String rprice;
  String roomRp;
  String roomUsd;
  String otherInc;
  String br;
  String dbinsert;
  String dbupdate;
  String insertBy;
  String pcId;
  String ketId;
  String rateBf;
  String tpax;
  String komisi;
  String tra;
  String discSen;
  String discNom;
  String moveBill;
  String dummyNom;
  String masuk;
  String tglClosecc;
  String aversi;
  String paxBf;
  String extraBed;
  String rebate;
  String nmExtrabed;
  String tglCancel;
  String ratecode;
  String kdSeason;
  String tanggal;
  String komisiSen;
  String sortdate;
  String res;
  String formatrdate;

  ReservasiDateData(
      {this.noRef,
      this.noRes,
      this.noRoom,
      this.rdate,
      this.typebook,
      this.typeday,
      this.rprice,
      this.roomRp,
      this.roomUsd,
      this.otherInc,
      this.br,
      this.dbinsert,
      this.dbupdate,
      this.insertBy,
      this.pcId,
      this.ketId,
      this.rateBf,
      this.tpax,
      this.komisi,
      this.tra,
      this.discSen,
      this.discNom,
      this.moveBill,
      this.dummyNom,
      this.masuk,
      this.tglClosecc,
      this.aversi,
      this.paxBf,
      this.extraBed,
      this.rebate,
      this.nmExtrabed,
      this.tglCancel,
      this.ratecode,
      this.kdSeason,
      this.tanggal,
      this.komisiSen,
      this.sortdate,
      this.res,
      this.formatrdate});

  ReservasiDateData.fromJson(Map<String, dynamic> json) {
    noRef = json['no_ref'];
    noRes = json['no_res'];
    noRoom = json['no_room'];
    rdate = json['rdate'];
    typebook = json['typebook'];
    typeday = json['typeday'];
    rprice = json['rprice'];
    roomRp = json['room_rp'];
    roomUsd = json['room_usd'];
    otherInc = json['other_inc'];
    br = json['br'];
    dbinsert = json['dbinsert'];
    dbupdate = json['dbupdate'];
    insertBy = json['insert_by'];
    pcId = json['pc_id'];
    ketId = json['ket_id'];
    rateBf = json['rate_bf'];
    tpax = json['tpax'];
    komisi = json['komisi'];
    tra = json['tra'];
    discSen = json['disc_sen'];
    discNom = json['disc_nom'];
    moveBill = json['move_bill'];
    dummyNom = json['dummy_nom'];
    masuk = json['masuk'];
    tglClosecc = json['tgl_closecc'];
    aversi = json['aversi'];
    paxBf = json['pax_bf'];
    extraBed = json['extra_bed'];
    rebate = json['rebate'];
    nmExtrabed = json['nm_extrabed'];
    tglCancel = json['tgl_cancel'];
    ratecode = json['ratecode'];
    kdSeason = json['kd_season'];
    tanggal = json['tanggal'];
    komisiSen = json['komisi_sen'];
    sortdate = json['sortdate'];
    res = json['res'];
    formatrdate = json['formatrdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_ref'] = this.noRef;
    data['no_res'] = this.noRes;
    data['no_room'] = this.noRoom;
    data['rdate'] = this.rdate;
    data['typebook'] = this.typebook;
    data['typeday'] = this.typeday;
    data['rprice'] = this.rprice;
    data['room_rp'] = this.roomRp;
    data['room_usd'] = this.roomUsd;
    data['other_inc'] = this.otherInc;
    data['br'] = this.br;
    data['dbinsert'] = this.dbinsert;
    data['dbupdate'] = this.dbupdate;
    data['insert_by'] = this.insertBy;
    data['pc_id'] = this.pcId;
    data['ket_id'] = this.ketId;
    data['rate_bf'] = this.rateBf;
    data['tpax'] = this.tpax;
    data['komisi'] = this.komisi;
    data['tra'] = this.tra;
    data['disc_sen'] = this.discSen;
    data['disc_nom'] = this.discNom;
    data['move_bill'] = this.moveBill;
    data['dummy_nom'] = this.dummyNom;
    data['masuk'] = this.masuk;
    data['tgl_closecc'] = this.tglClosecc;
    data['aversi'] = this.aversi;
    data['pax_bf'] = this.paxBf;
    data['extra_bed'] = this.extraBed;
    data['rebate'] = this.rebate;
    data['nm_extrabed'] = this.nmExtrabed;
    data['tgl_cancel'] = this.tglCancel;
    data['ratecode'] = this.ratecode;
    data['kd_season'] = this.kdSeason;
    data['tanggal'] = this.tanggal;
    data['komisi_sen'] = this.komisiSen;
    data['sortdate'] = this.sortdate;
    data['res'] = this.res;
    data['formatrdate'] = this.formatrdate;
    return data;
  }
}
