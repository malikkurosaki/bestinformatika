import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:probus_mobile/models_presto/model_sales_performance.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';

import 'master/master_date.dart';
import 'master/master_dept.dart';


class SalesPerformance extends Bantuan{
  static final lsData = <ModelSalesPerformance>[].obs;
  static final load = false.obs;
  final bool denganJudul;

  static final lsBulan = {
    "1":"jan", 
    "2":"feb", 
    "3":"mar", 
    "4":"apr", 
    "5":"may", 
    "6":"jun", 
    "7":"jul", 
    "8":"ags", 
    "9":"sep", 
    "10":"okt", 
    "11":"nov", 
    "12":"des"
  };

  SalesPerformance({this.denganJudul});

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
              Container(
                margin: EdgeInsets.all(2),
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: FlipCard(
                            onFlip: () => Suara.soundPool.play(Suara.waterId),
                            direction: FlipDirection.VERTICAL,
                            front: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Icon(
                                  Icons.attach_money,
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
                                        color: Colors.cyan,
                                        padding: EdgeInsets.all(4),
                                        child: Center(
                                          child: Text(lsBulan[ls.month.toString()].toUpperCase()??"",
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
                            back: Container(
                              color: Colors.white,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    size: 42,
                                    color: Colors.cyan[50],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.cyan,
                                          padding: EdgeInsets.all(4),
                                          child: Center(
                                            child: Text(lsBulan[ls.month.toString()].toUpperCase()??"",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          child: Container(
                            height: 10,
                            width: 4,
                          ),
                        ),
                        Card(
                          child: Container(
                            height: 10,
                            width: 4,
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
      theData == null? RestRestponseRestaurant.salesPerformance.map((e) => ModelSalesPerformance.fromJson(e)).toList():
      (theData as List).map((e) => ModelSalesPerformance.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.salesPerformance();

  @override
  String get title => "Sales Performance";

}

// /// [date] dan [dept]
// class SalesPerformance extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) => 
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(SalesPerformanceCtrl.judul.value).boldUpper,
//       Row(
//         children: [
//           Container(
//             color: Colors.grey[300],
//             child: MasterDate((_) => SalesPerformanceCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterDept((_) => SalesPerformanceCtrl.init()),
//           )
//         ],
//       ),
//       GetX(
//         initState: (state) => SalesPerformanceCtrl.init(),
//         builder: (controller) => SalesPerformanceCtrl.loading.value?
//         Text(SalesPerformanceCtrl.loadingText.value):
//         GridView.count(
//           crossAxisCount: 4,
//           shrinkWrap: true,
//           physics: ScrollPhysics(),
//           children: [
//             for(final spf in SalesPerformanceCtrl.lsData)
//             Card(
//               child: Column(
//                 children: [
//                   Text(spf?.month?.toString()??""),
//                   Text(spf?.value?.toString()??"")
//                 ],
//               ),
//             )
//           ],
//         )
//       )
//     ],
//   );

// }

// class SalesPerformanceCtrl extends MyCtrl{
//   static final lsData = <ModelSalesPerformance>[].obs;
//   static final loading = false.obs;
//   static final loadingText = "loading ...".obs;
//   static final judul = "Sales Performance".obs;

//   static Future init()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static Future getData()async{
//     final data = await RestApi.salesPerformance();
//     lsData.assignAll(data == null? 
//     List.filled(4, ModelSalesPerformance()): 
//     (data as List).map((e) => ModelSalesPerformance.fromJson(e)).toList());
//   }
// }