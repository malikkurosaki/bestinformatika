import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_reservation.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class Reservation extends Bantuan{
  static final lsData = <ModelReservation>[].obs;
  static final load = false.obs;

  final String gambar;
  Reservation(this.gambar);

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: false,
    onFinis: () => lsData.isEmpty?
    Text("..."):BantuanWidget.ambil.empatPilarButton(
      lsData: lsData, 
      title: title,
      invalidData: invalidData.value, 
      gambar: gambar
    ),
  );
  
  @override
  void datanya(theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.reservation.map((e) => ModelReservation.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelReservation.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.reservation();

  @override
  String get title => "Reservation";
  
}