

import 'package:probus_mobile/components_phis/hotel_home.dart';

class ModelHotelHome{
  Occupancy occupancy;
  RoomSales roomSales;
  RoomSales roomUnSold;
  Revenue revenue;
  Guest guest;
  RoomSales roomRate;
  RoomSales lenghtOfStay;
  ReservationSummary reservationSummary;
  InHouseSummary inHouseSummary;
  List<RoomProduction> roomProduction;

  ModelHotelHome(
      {this.occupancy,
      this.roomSales,
      this.roomUnSold,
      this.revenue,
      this.guest,
      this.roomRate,
      this.lenghtOfStay,
      this.reservationSummary,
      this.inHouseSummary,
      this.roomProduction});

  @override
  ModelHotelHome.fromJson(Map<String, dynamic> json) {
    occupancy = json['occupancy'] != null
        ? new Occupancy.fromJson(json['occupancy'])
        : null;
    roomSales = json['roomSales'] != null
        ? new RoomSales.fromJson(json['roomSales'])
        : null;
    roomUnSold = json['roomUnSold'] != null
        ? new RoomSales.fromJson(json['roomUnSold'])
        : null;
    revenue =
        json['revenue'] != null ? new Revenue.fromJson(json['revenue']) : null;
    guest = json['guest'] != null ? new Guest.fromJson(json['guest']) : null;
    roomRate = json['roomRate'] != null
        ? new RoomSales.fromJson(json['roomRate'])
        : null;
    lenghtOfStay = json['lenghtOfStay'] != null
        ? new RoomSales.fromJson(json['lenghtOfStay'])
        : null;
    reservationSummary = json['reservationSummary'] != null
        ? new ReservationSummary.fromJson(json['reservationSummary'])
        : null;
    inHouseSummary = json['inHouseSummary'] != null
        ? new InHouseSummary.fromJson(json['inHouseSummary'])
        : null;
    if (json['roomProduction'] != null) {
      roomProduction = <RoomProduction>[];
      json['roomProduction'].forEach((v) {
        roomProduction.add(new RoomProduction.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.occupancy != null) {
      data['occupancy'] = this.occupancy.toJson();
    }
    if (this.roomSales != null) {
      data['roomSales'] = this.roomSales.toJson();
    }
    if (this.roomUnSold != null) {
      data['roomUnSold'] = this.roomUnSold.toJson();
    }
    if (this.revenue != null) {
      data['revenue'] = this.revenue.toJson();
    }
    if (this.guest != null) {
      data['guest'] = this.guest.toJson();
    }
    if (this.roomRate != null) {
      data['roomRate'] = this.roomRate.toJson();
    }
    if (this.lenghtOfStay != null) {
      data['lenghtOfStay'] = this.lenghtOfStay.toJson();
    }
    if (this.reservationSummary != null) {
      data['reservationSummary'] = this.reservationSummary.toJson();
    }
    if (this.inHouseSummary != null) {
      data['inHouseSummary'] = this.inHouseSummary.toJson();
    }
    if (this.roomProduction != null) {
      data['roomProduction'] =
          this.roomProduction.map((v) => v.toJson()).toList();
    }
    return data;
  }

  
}

class Occupancy {
  dynamic yesterday;
  dynamic today;
  dynamic tomorrow;

  Occupancy({this.yesterday, this.today, this.tomorrow});

  Occupancy.fromJson(Map<String, dynamic> json) {
    yesterday = json['yesterday'];
    today = json['today'];
    tomorrow = json['tomorrow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yesterday'] = this.yesterday;
    data['today'] = this.today;
    data['tomorrow'] = this.tomorrow;
    return data;
  }
}

class RoomSales {
  dynamic today;
  dynamic yesterday;

  RoomSales({this.today, this.yesterday});

  RoomSales.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    yesterday = json['yesterday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today'] = this.today;
    data['yesterday'] = this.yesterday;
    return data;
  }
}

class Revenue {
  dynamic today;
  dynamic yesterday;

  Revenue({this.today, this.yesterday});

  Revenue.fromJson(Map<String, dynamic> json) {
    today = json['today'];
    yesterday = json['yesterday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['today'] = this.today;
    data['yesterday'] = this.yesterday;
    return data;
  }
}

class Guest {
  dynamic todayAdult;
  dynamic todayChild;
  dynamic yesterdayAdult;
  dynamic yesterdayChild;

  Guest(
      {this.todayAdult,
      this.todayChild,
      this.yesterdayAdult,
      this.yesterdayChild});

  Guest.fromJson(Map<String, dynamic> json) {
    todayAdult = json['todayAdult'];
    todayChild = json['todayChild'];
    yesterdayAdult = json['yesterdayAdult'];
    yesterdayChild = json['yesterdayChild'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todayAdult'] = this.todayAdult;
    data['todayChild'] = this.todayChild;
    data['yesterdayAdult'] = this.yesterdayAdult;
    data['yesterdayChild'] = this.yesterdayChild;
    return data;
  }
}

class ReservationSummary {
  dynamic booking;
  dynamic confirmed;
  dynamic canceled;
  dynamic noShow;

  ReservationSummary(
      {this.booking, this.confirmed, this.canceled, this.noShow});

  ReservationSummary.fromJson(Map<String, dynamic> json) {
    booking = json['Booking'];
    confirmed = json['Confirmed'];
    canceled = json['Canceled'];
    noShow = json['No Show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Booking'] = this.booking;
    data['Confirmed'] = this.confirmed;
    data['Canceled'] = this.canceled;
    data['No Show'] = this.noShow;
    return data;
  }
}

class InHouseSummary {
  dynamic houseUsed;
  dynamic compliment;
  dynamic payRoom;
  dynamic outOfOrder;

  InHouseSummary(
      {this.houseUsed, this.compliment, this.payRoom, this.outOfOrder});

  InHouseSummary.fromJson(Map<String, dynamic> json) {
    houseUsed = json['House Used'];
    compliment = json['Compliment'];
    payRoom = json['Pay Room'];
    outOfOrder = json['Out Of Order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['House Used'] = this.houseUsed;
    data['Compliment'] = this.compliment;
    data['Pay Room'] = this.payRoom;
    data['Out Of Order'] = this.outOfOrder;
    return data;
  }
}

class RoomProduction {
  dynamic kdAgen;
  dynamic nmAgen;
  dynamic value;
  dynamic revenue;

  RoomProduction({this.kdAgen, this.nmAgen, this.value, this.revenue});

  RoomProduction.fromJson(Map<String, dynamic> json) {
    kdAgen = json['kd_agen'];
    nmAgen = json['nm_agen'];
    value = json['value'];
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_agen'] = this.kdAgen;
    data['nm_agen'] = this.nmAgen;
    data['value'] = this.value;
    data['revenue'] = this.revenue;
    return data;
  }
}
