import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_inhouse.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class InHouse extends Bantuan{
  static final lsData = <ModelInHouse>[].obs;
  static final load = false.obs;

  final String gambar;
  InHouse(this.gambar);

  @override
  Widget build(BuildContext context) => 
  buat(
    denganJudul: false,
    onFinis: () => 
    lsData.isEmpty?
    Text("..."):
    BantuanWidget.ambil.empatPilarButton(
      lsData: lsData, 
      title: title,
      invalidData: invalidData.value, 
      gambar: gambar
    ),
  );

  @override
  void datanya(theData){
    theData == null?
    lsData.assignAll(RestRestponsePhis.inhouse.map((e) => ModelInHouse.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelInHouse.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.inHouse();

  @override
  String get title => "Inhouse";

 
}