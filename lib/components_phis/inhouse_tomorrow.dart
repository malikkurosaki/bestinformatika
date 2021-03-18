import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/components_phis/hotel_home.dart';
import 'package:probus_mobile/models_phis/model_hotel_home.dart';
import 'package:probus_mobile/models_phis/model_inhouse_tomorrow.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class InHouseTomorrow extends Bantuan{

  static final lsData = <ModelInHouseTomorrow>[].obs;
  static final load = false.obs;

  final String gambar;
  InHouseTomorrow(this.gambar);

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: false,
    onFinis: () => 
    lsData.isEmpty?
    Text("data is empty"):
    BantuanWidget.ambil.empatPilarButton(
      lsData: lsData, 
      title: title,
      invalidData: invalidData.value, 
      gambar: gambar
    ),
  );

  @override
  void datanya(theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.inHouseTomorrow.map((e) => ModelInHouseTomorrow.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelInHouseTomorrow.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.inhouseTomorrow();

  @override
  String get title => "Inhouse Tomorrow";


}