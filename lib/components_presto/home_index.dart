import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/components_presto/master/master_date.dart';
import 'package:probus_mobile/components_presto/master/master_dept.dart';
import 'package:probus_mobile/main.dart';
import 'package:probus_mobile/models_presto/model_home_index.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';

/// static final lsData = <ModelDailyRevenue>[].obs; 
/// static final load = false.obs;
/// 

class PrestoHomeIndex extends Bantuan{

  static final lsData = <ModelHomeIndex>[].obs; 
  static final load = false.obs;
  final denganJudul;

  PrestoHomeIndex({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul??false,
    onFinis: () => 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          child: Wrap(
            children: [
              MasterDate((_) => init()),
              MasterDept((_) => init())
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: GridView.extent(
            maxCrossAxisExtent: 150,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for(final ls in lsData)
              Container(
                padding: EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Flexible(
                      child: FlipCard(
                        onFlip: () => Suara.soundPool.play(Suara.soundId),
                        front: Card(
                          color: Colors.blue,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Center(
                                        child: Text(ls?.today?.toString()??"").judulBoldPutih,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Today",
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                              Transform.translate(
                                offset: Offset(-50, 25),
                                child: Icon(Icons.ac_unit,
                                  size: 72,
                                  color: Colors.white30,
                                ),
                              )
                            ],
                          )
                        ),
                        back: Card(
                          color: Colors.orange,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Center(
                                        child: Text(ls?.yesterday?.toString()??"").judulBoldPutih,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Yesterday",
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ),
                              Transform.translate(
                                offset: Offset(50, -25),
                                child: Icon(Icons.ac_unit,
                                  size: 72,
                                  color: Colors.white30,
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                    Text(ls?.title??"").judul,
                  ],
                )
                // Column(
                //   children: [
                //     Flexible(
                //       child: 
                //       ,
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 8),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Yesterday"),
                //           Text(ls?.yesterday?.toString()??""),
                //         ],
                //       ),
                //     ),
                //     Text(ls?.title??"").judul,
                //   ],
                // ),
              )
            ],
          ),
        )
      ],
    )
  );
  
  @override
  void datanya(theData) {
   lsData.assignAll(
     theData == null? RestRestponseRestaurant.homeIndex.map((e) => ModelHomeIndex.fromJson(e)).toList():
     (theData as List).map((e) => ModelHomeIndex.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.homeindex();

  @override
  String get title => "Presto Home Index";
}

// // [date], [dept]
// class PrestoHomeIndex extends StatelessWidget{

//   @override
//   Widget build(BuildContext context) =>
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text("Home Index").boldUpper,
//       Row(
//         children: [
//           Container(
//             margin: EdgeInsets.only(right: 1),
//             color: Colors.grey[300],
//             child: MasterDate((_) => PrestoHomeIndexCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterDept((_) => PrestoHomeIndexCtrl.init()),
//           ),
//         ],
//       ),
//       GetX(
//         initState: (state) => PrestoHomeIndexCtrl.init(),
//         builder: (controller) => PrestoHomeIndexCtrl.loading.value?
//         Text(PrestoHomeIndexCtrl.loadingText.value):
//         GridView.count(
//           physics: ScrollPhysics(),
//           shrinkWrap: true,
//           crossAxisCount: 4,
//           children: [
//             for(final phi in PrestoHomeIndexCtrl.lsData)
//             Card(
//               child: Column(
//                 children: [
//                   Text(phi?.title?.toString()??""),
//                   Text(phi?.today?.toString()??""),
//                   Text(phi?.yesterday?.toString()??"empty data")
//                 ],
//               ),
//             )
//           ],
//         )
//       ),
//     ],
//   );

// }

// class PrestoHomeIndexCtrl extends MyCtrl{
//   static final lsData = <ModelHomeIndex>[].obs;
//   static final loading = false.obs;
//   static final loadingText = "loading ...".obs;

//   static Future init()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static Future getData()async{
//     final data = await RestApi.homeindex();
//     lsData.assignAll(data == null ? 
//     List.filled(4, ModelHomeIndex()): 
//     (data as List).map((e) => ModelHomeIndex.fromJson(e)).toList());
//   }
// }
  