import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_arrival_tomorrow.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class ArrivalTomorrow extends Bantuan{
  static final lsData = <ModelArrivalTomorrow>[].obs;
  static final load = false.obs;
  
  final String gambar;
  ArrivalTomorrow(this.gambar);
  
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

  void datanya(dynamic theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.arrivalTomorrow.map((e) => ModelArrivalTomorrow.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelArrivalTomorrow.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.arrivalTomorrow();

  @override
  String get title => "Arrival Tomorrow";

  
  
}