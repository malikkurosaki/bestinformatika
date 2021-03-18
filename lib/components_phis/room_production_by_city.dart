

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probus_mobile/models_phis/model_room_production_by_city.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class RoomProductionByCity extends Bantuan{
  static final lsData = <ModelRoomProductionByCity>[].obs;
  static final load = false.obs;
  final denganJudul;

  RoomProductionByCity({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul,
    onFinis: () => 
    GridView.count(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 4,
      children: [
        for(final ls in lsData)
        FlipCard(
          front: Card(
            color: Colors.lightBlue,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Icon(
                  Icons.flare,
                  size: 42,
                  color: Colors.white24,
                ),
                Center(
                  child: Text(ls.city),
                ),
              ],
            ),
          ), 
          back: Card(
            color: Colors.orange,
            child: Center(
              child: Text(ls.value.toString()),
            ),
          )
        )
      ],
    ), 
  );
  
  @override
  void datanya(theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.roomProductionByCity.map((e) => ModelRoomProductionByCity.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelRoomProductionByCity.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.roomProductionByCity();

  @override
  String get title => "Room Production By City";

}