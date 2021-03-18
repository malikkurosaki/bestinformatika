import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_arrival.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class Arrival extends Bantuan{
  static final lsData = <ModelArrival>[].obs;
  static final load = false.obs;

  final String gambar;
  Arrival(this.gambar);
  
  @override
  Widget build(BuildContext context) =>
  buat(
    onFinis: () => 
    lsData.isEmpty?
    Text("..."):
    BantuanWidget.ambil.empatPilarButton(
      lsData: lsData, 
      title: title,
      invalidData: invalidData.value, 
      gambar: gambar
    ), 
    denganJudul: false,
  );
  
  @override
  void datanya(dynamic theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.arrival.map((e) => ModelArrival.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelArrival.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.arrival();

  @override
  String get title => "Arrival";
}
