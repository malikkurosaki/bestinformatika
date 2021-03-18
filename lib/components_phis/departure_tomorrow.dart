import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_arrival_tomorrow.dart';
import 'package:probus_mobile/models_phis/model_departure_tomorrow.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class DepartureTomorrow extends Bantuan{
  static final lsData = <ModelDepartureTomorrow>[].obs;
  static final load = false.obs;

  final String gambar;
  DepartureTomorrow(this.gambar);

  @override
  Widget build(BuildContext context) =>
  buat(
    onFinis: () => 
    lsData.isEmpty?
    Text("data is empty"):
    BantuanWidget.ambil.empatPilarButton(
      lsData: lsData, 
      title: title,
      invalidData: invalidData.value, 
      gambar: gambar
    ), 
    denganJudul: false
  );


  @override
  void datanya(theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.departureTomorrow.map((e) => ModelDepartureTomorrow.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelDepartureTomorrow.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.departureTomorrow();

  @override
  String get title => "Departure Tomorrow";
  
}