import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/models_presto/model_sales_trafic.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';

import '../store.dart';
import 'master/master_date.dart';
import 'master/master_dept.dart';


class SalesTrafic extends Bantuan{
  static final lsData = <ModelSalesTrafic>[].obs;
  static final laod = false.obs;
  final bool denganJudul;

  SalesTrafic({this.denganJudul});

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
          padding: EdgeInsets.all(8),
          child: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for(final ls in lsData)
              Stack(
                children: [
                  Container(
                    color: Colors.grey[300],
                    margin: EdgeInsets.all(1),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: FlipCard(
                            onFlip: () => Suara.soundPool.play(Suara.waterId),
                            direction: FlipDirection.VERTICAL,
                            front: Container(
                              color: Colors.blueGrey[50],
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Icon(
                                    Icons.show_chart_rounded,
                                    size: 42,
                                    color: Colors.black12,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.blue,
                                          padding: EdgeInsets.all(4),
                                          child: Center(
                                            child: Text(ls?.date?.toString()??"",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                              ),
                                            ),
                                          )
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(ls?.value?.toString()).judulBold,
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ), 
                            back: Container(
                              color: Colors.blueGrey[50],
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Icon(
                                    Icons.show_chart_rounded,
                                    size: 42,
                                    color: Colors.black12,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.blue,
                                          padding: EdgeInsets.all(4),
                                          child: Center(
                                            child: Text(ls?.date?.toString()??"",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                              ),
                                            )
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Text(ls?.value?.toString()).judulBold,
                                            ),
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: Container(
                          height: 15,
                          width: 4,
                        ),
                      ),
                      Card(
                        child: Container(
                          height: 15,
                          width: 4,
                        ),
                      )
                    ],
                  )
                ],
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
     theData == null? RestRestponseRestaurant.salesTrafic.map((e) => ModelSalesTrafic.fromJson(e)).toList():
     (theData as List).map((e) => ModelSalesTrafic.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => laod;

  @override
  Future get restApi => RestApi.salesTrafic();

  @override
  String get title => "Sales Trafic";
}


// /// [date] dan [dept]
// class SalesTrafic extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) => 
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(SalesTraficCtrl.judul.value).boldUpper,
//       Row(
//         children: [
//           Container(
//             color: Colors.grey[300],
//             child: MasterDate((_) => SalesTraficCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterDept((_) => SalesTraficCtrl.init()),
//           )
//         ],
//       ),
//       GetX(
//         initState: (state) => SalesTraficCtrl.init(),
//         builder: (controller) => SalesTraficCtrl.loading.value?
//         Text(SalesTraficCtrl.loadingText.value):
//         GridView.count(
//           crossAxisCount: 4,
//           shrinkWrap: true,
//           physics: ScrollPhysics(),
//           children: [
//             for(final stf in SalesTraficCtrl.lsData)
//             Card(
//               child: Column(
//                 children: [
//                   Text(stf?.date?.toString()??""),
//                   Text(stf?.value?.toString()??"")
//                 ],
//               ),
//             )
//           ],
//         )
//       )
//     ],
//   );

// }

// class SalesTraficCtrl extends MyCtrl{
//   static final lsData = <ModelSalesTrafic>[].obs;
//   static final loading = false.obs;
//   static final loadingText = "loading ...".obs;
//   static final judul = "Sales Trafic".obs;

//   static Future init()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static Future getData()async{
//     final data = await RestApi.salesTrafic();
//     lsData.assignAll(data == null? 
//     List.filled(4, ModelSalesTrafic()): 
//     (data as List).map((e) => ModelSalesTrafic.fromJson(e)).toList());
//   }
// }