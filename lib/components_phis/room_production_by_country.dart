import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_room_production_by_country.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/tema.dart';

class RoomProductionByCountry extends Bantuan{
  static final lsData = <ModelRoomProductionByCountry>[].obs;
  static final load = false.obs;
  final denganJudul;

  RoomProductionByCountry({this.denganJudul});

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
            color: Colors.blue[900],
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Icon(
                  Icons.home,
                  size: 42,
                  color: Colors.white24,
                ),
                Center(
                  child: Text(ls.country,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),

              ],
            ),
          ), 
          back: Card(
            color: Colors.orange[900],
            child: Center(
              child: Text(ls.value.toString(),
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          )
        )
      ],
    ), 
  );

  @override
  void datanya(theData) {
    theData == null?
    lsData.assignAll(RestRestponsePhis.roomProductionbyCountry.map((e) => ModelRoomProductionByCountry.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelRoomProductionByCountry.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.roomProductionByCountry();

  @override
  String get title => "Room Production By Country";


}