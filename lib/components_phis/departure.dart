import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_departure.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class Departure extends Bantuan{
  static final lsData = <ModelDeparture>[].obs;
  static final load = false.obs;

  final String gambar;
  Departure(this.gambar);

  @override
  Widget build(BuildContext context) =>
  buat(
    onFinis: () => lsData.isEmpty?
    Text("..."):
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
    lsData.assignAll(RestRestponsePhis.departure.map((e) => ModelDeparture.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelDeparture.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.departure();


  @override
  String get title => "Departure";

  
}