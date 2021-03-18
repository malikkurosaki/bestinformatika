import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_room_production.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';



/// abbandoned
class RoomProduction extends Bantuan{
  static final lsData = <ModelRoomProduction>[].obs;
  static final load = false.obs;
  final denganJudul;

  RoomProduction({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul,
    onFinis: () => 
    Column(
      children: [
        Row(
          children: [
            Container(
              width: Get.width/4,
              child: Text("Agent").judul
            ),
            Expanded(child: Text("Name").judul),
            Text("Value").judul
          ],
        ),
        for(final ls in lsData)
        Row(
          children: [
            Container(
              width: Get.width/4,
              child: Text(ls.kdAgen.toString())
            ),
            Expanded(child: Text(ls.nmAgen.toString())),
            Text(ls.value.toString())
          ],
        )
      ],
    ), 
  );
  
  @override
  void datanya(theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.roomProduction.map((e) => ModelRoomProduction.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelRoomProduction.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.roomProduction();


  @override
  String get title => "Room Production";


}