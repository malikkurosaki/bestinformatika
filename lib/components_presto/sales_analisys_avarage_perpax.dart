import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:probus_mobile/components_presto/master/master_tipe.dart';
import 'package:probus_mobile/models_presto/model_sales_analisys_avarage_bill_perpax.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';

import 'master/master_date.dart';
import 'master/master_dept.dart';

class SalesAnalisysAvaragePerPax extends Bantuan{

  static final lsData = <ModelSalesAnalisysByAvarageBillPax>[].obs;
  static final load = false.obs;
  final bool denganJudul;

  SalesAnalisysAvaragePerPax({this.denganJudul});


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
              MasterDept((_) => init()),
              MasterTipe(
                hasil: (_) => init(), 
                lsTipe: ["DTD", "YTD"]
              )
            ],
          ),
        ),
        Center(
          child: Card(
            elevation: 5,
            color: Colors.teal,
            child: Container(
              padding: EdgeInsets.all(4),
              child: Wrap(
                children: [
                  for(final ls in lsData)
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(ls?.label?.toString()??""),
                        Chip(
                          label: Text(ls?.value?.toString()??"")
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    )
  );
  
  @override
  void datanya(theData) {
    print(theData);
    lsData.assignAll(
      theData == null? RestRestponseRestaurant.salesAnalisysByBillPax.map((e) => ModelSalesAnalisysByAvarageBillPax.fromJson(e)).toList():
      (theData as List).map((e) => ModelSalesAnalisysByAvarageBillPax.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.salesAnalysisByAvarageBillPax();

  @override
  String get title => "Sales Analisys By Avarage Bill Pax";

}

// class SalesAnalisysAvaragePerPax extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) =>
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(SalesAnalisysAvaragePerPaxCtrl.judul.value).boldUpper,
//       Row(
//         children: [
//           Container(
//             color: Colors.grey[300],
//             child: MasterDate((_) => SalesAnalisysAvaragePerPaxCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterDept((_) => SalesAnalisysAvaragePerPaxCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterTipe(
//               hasil: (_) => SalesAnalisysAvaragePerPaxCtrl.init(), 
//               lsTipe: ["DTD", "YTD"]
//             ),
//           )
//         ],
//       ),
//       GetX(
//         initState: (state) => SalesAnalisysAvaragePerPaxCtrl.init(),
//         builder: (controller) => SalesAnalisysAvaragePerPaxCtrl.loading.value?
//         Text(SalesAnalisysAvaragePerPaxCtrl.loadingTet.value):
//         GridView.count(
//           shrinkWrap: true,
//           physics: ScrollPhysics(),
//           crossAxisCount: 4,
//           children: [
//             for(final sap in SalesAnalisysAvaragePerPaxCtrl.lsData)
//             Card(
//               child: Column(
//                 children: [
//                   Text(sap?.label?.toString()??""),
//                   Text(sap?.value?.toString()??"")
//                 ],
//               ),
//             )
//           ],
//         )
//       ),
//     ],
//   );

// }

// class SalesAnalisysAvaragePerPaxCtrl extends MyCtrl{
//   static final lsData = <ModelSalesAnalisysByAvarageBillPax>[].obs;
//   static final loading = false.obs;
//   static final loadingTet = "loading ...".obs;
//   static final judul = "Sales Analisis Avarage Per Pax".obs;

//   static Future init()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static Future getData()async{
//     final data = await RestApi.salesAnalysisByAvarageBillPax();
//     lsData.assignAll(data == null? 
//     List.filled(4, ModelSalesAnalisysByAvarageBillPax()): 
//     (data as List).map((e) => ModelSalesAnalisysByAvarageBillPax.fromJson(e)).toList());
//   }
// }