import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_phis/model_fore_cast_occupancy.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_restponse_phis.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';

class ForecastOcccupancy extends Bantuan{
  static final lsData = <ModelForeCastOccupancy>[].obs;
  static final load = false.obs;
  final month = {
    "1": "JAN", 
    "2": "FEB", 
    "3": "MAR", 
    "4": "APR", 
    "5": "MAY", 
    "6": "JUN", 
    "7": "JUL", 
    "8": "AGS", 
    "9": "SEP", 
    "10": "OKT", 
    "11": "NOV", 
    "12": "DES"
  };

  final denganJudul;
  ForecastOcccupancy({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul,
    onFinis: () => 
    GridView.count(
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      crossAxisCount: 5,
      children: [
        for(final ls in lsData)
        FlipCard(
          onFlip: () => Suara.soundPool.play(Suara.waterId),
          front: Container(
            margin: EdgeInsets.all(1),
            color: Colors.lightBlueAccent,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Transform.translate(
                  offset: Offset(15, 0),
                  child: Icon(
                    Icons.local_florist_outlined,
                    size: 34,
                    color: Colors.white30,
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(month[ls.month.toString()].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    )
                  ),
                ),
              ],
            ),
          ), 
          back: Container(
            margin: EdgeInsets.all(1),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SpinKitPulse(
                    color: Colors.orange,
                    size: Get.width / 5,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(month[ls.month.toString()].toString()).judulBold,
                      Text(ls?.occupancy?.toString()).judulBold,
                    ],
                  ),
                  
                ),
              ],
            ),
          )
        )
       
      ],
    )
  );
  
  @override
  void datanya(theData) {
    // print(theData);
    theData== null?
    lsData.assignAll(RestRestponsePhis.foreCastOccupancy.map((e) => ModelForeCastOccupancy.fromJson(e)).toList()):
    lsData.assignAll((theData as List).map((e) => ModelForeCastOccupancy.fromJson(e)).toList());
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.forecastOcc();

  @override
  String get title => "ForeCast Occupancy";

}