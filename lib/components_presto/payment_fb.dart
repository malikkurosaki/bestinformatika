
import 'dart:math';

import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:probus_mobile/components_presto/home_index.dart';
import 'package:probus_mobile/components_presto/master/master_date.dart';
import 'package:probus_mobile/components_presto/master/master_dept.dart';
import 'package:probus_mobile/models_presto/model_payment_fb.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';
import 'package:get/get.dart';

class PaymentFb extends Bantuan{
  static final lsData = <ModelPaymentFb>[].obs; 
  static final load = false.obs;
  final bool denganJudul;
  static final rotate = 20.0.obs;
  static final toggle = false.obs;
  static final muncul = false.obs;

  PaymentFb({this.denganJudul});

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
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            children: [
              for(final ls in lsData)
              Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => toggle.value = !toggle.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            color: Colors.cyan,
                            margin: EdgeInsets.all(1),
                            padding: EdgeInsets.all(8),

                          ),
                          Obx(() => 
                            AnimatedContainer(
                              alignment: toggle.value?Alignment.topLeft: Alignment.bottomRight,
                              duration: Duration(milliseconds: Random().nextInt(2000)+50),
                              child: Icon(
                                Icons.ac_unit,
                                size: 42,
                                color: Colors.white30,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(ls?.value?.toString()??"").judulBoldPutih,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    child: Text(ls?.type?.toString()??"",
                      overflow: TextOverflow.ellipsis,
                    )
                  )
                ],
              )
            ],
          ),
        )
        // for(final ls in lsData)
        // Row(
        //   children: [
        //     InkWell(
        //       onTap: () {

        //         Suara.soundPool.play(Suara.waterId);
        //         toggle.value = !toggle.value;
        //       },
        //       child: Card(
        //         color: Colors.blueAccent,
        //         child: Container(
        //           width: 150,
        //           padding: EdgeInsets.all(8),
        //           child: Text(ls?.type?.toString()??"",
        //             overflow: TextOverflow.ellipsis,
        //             style: TextStyle(
        //               color: Colors.white
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: Obx(
        //         () =>
        //         AnimatedContainer(
        //           transform: Matrix4.rotationZ(toggle.value?0:20.4),
        //           duration: Duration(milliseconds: Random().nextInt(1000) + 100),
        //           onEnd: () async{
        //             if(!toggle.value) await Future.delayed(Duration(milliseconds: 500)); 
        //             muncul.value = toggle.value;
        //           },
        //           child: Visibility(
        //             visible: muncul.value,
        //             child: Card(
        //               color: Colors.orange,
        //               child: Stack(
        //                 children: [
        //                   Container(
        //                     padding: EdgeInsets.all(8),
        //                     child: Text(ls?.value?.toString()??"").judulBoldPutih
        //                   ),
        //                   Align(
        //                     alignment: Alignment.bottomRight,
        //                     child: Transform.translate(
        //                       offset: Offset(0, 20),
        //                       child: Icon(Icons.ac_unit_rounded,
        //                         size: 24,
        //                         color: Colors.white30,
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               )
        //             ),
        //           ),
        //         )
        //       ),
        //     )
        //   ],
        // )
      ],
    )
  );
  
  @override
  void datanya(theData) {
    lsData.assignAll(
      theData == null? RestRestponseRestaurant.paymentFb.map((e) => ModelPaymentFb.fromJson(e)).toList():
      (theData as List).map((e) => ModelPaymentFb.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.paymentFb();

  @override
  String get title => "Payment Fb";

}



// class PaymentFb extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) => 
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       PaymentFbCtrl.judul == null? SizedBox.shrink(): Text(PaymentFbCtrl.judul.value).boldUpper,
//       Wrap(
//         children: [
//           Container(
//             color: Colors.grey[300],
//             child: MasterDate((_) => PaymentFbCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterDept((_) => PaymentFbCtrl.init()),
//           ),
//         ],
//       ),
//       GetX(
//         initState: (state) => PaymentFbCtrl.init(),
//         builder: (controller) => 
//         PaymentFbCtrl.loading.value?
//         Text(PaymentFbCtrl.loadingText.value): 
//         GridView.count(
//           physics: ScrollPhysics(),
//           shrinkWrap: true,
//           crossAxisCount: 4,
//           children: [
//             for(final pay in PaymentFbCtrl.lsData)
//             Card(
//               child: Column(
//                 children: [
//                   Text(pay?.id?.toString()??""),
//                   Text(pay?.type?.toString()??""),
//                   Text(pay?.value?.toString()??"empty data")
//                 ],
//               ),
//             )
//           ],
//         )
//       ),
//     ],
//   );
  
// }

// class PaymentFbCtrl extends MyCtrl{
//   static final lsData = <ModelPaymentFb>[].obs;
//   static final loading = false.obs;
//   static final loadingText = "loading ...".obs;
//   static final judul = "Payment Fb".obs;

//   static init()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static Future getData() async{
//     final data = await RestApi.paymentFb();
//     lsData.assignAll(data == null? 
//     List.filled(4, ModelPaymentFb()): 
//     (data as List).map((e) => ModelPaymentFb.fromJson(e)).toList());

//   }
  
// }





