import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:probus_mobile/components_presto/master/master_date.dart';
import 'package:probus_mobile/components_presto/master/master_dept.dart';
import 'package:probus_mobile/models_presto/model_transaction_summary.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';
import 'package:get/get.dart';


class TransactionSummary extends Bantuan{
  static final lsData = <ModelTransactionSummary>[].obs;
  static final load = false.obs;
  final bool denganJudul;

  TransactionSummary({this.denganJudul});

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
            physics: BouncingScrollPhysics(),
            crossAxisCount: 4,
            children: [
              for(final ls in lsData)
              Container(
                margin: EdgeInsets.all(2),
                color: Colors.blueGrey[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white30,
                              size: 62,
                            ),
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(ls?.qty?.toString()??"").judulBold
                                )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("NET"),
                                  Text(ls?.net?.toString()??"")
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.blueGrey,
                      padding: EdgeInsets.all(4),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(ls?.type?.toString()??"").boldPutih
                        ],
                      ),
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
      theData == null? RestRestponseRestaurant.transactionSummary.map((e) => ModelTransactionSummary.fromJson(e)).toList():
      (theData as List).map((e) => ModelTransactionSummary.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.transactionSummary();

  @override
  String get title => "Transaction Summary";
}

// /// transaction summary
// /// [date] dan [dept]
// class TransactionSummary extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) => 
//   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text("Transaction Summary").boldUpper,
//       Row(
//         children: [
//           Container(
//             color: Colors.grey[300],
//             child: MasterDate((_) => TransactionSummaryCtrl.init()),
//           ),
//           Container(
//             color: Colors.grey[300],
//             child: MasterDept((_) => TransactionSummaryCtrl.init()),
//           )
//         ],
//       ),
//       GetX(
//         initState: (state) => TransactionSummaryCtrl.init(),
//         builder: (controller) => TransactionSummaryCtrl.loading.value?
//         Text(TransactionSummaryCtrl.loadingText.value):
//         GridView.count(
//           crossAxisCount: 4,
//           shrinkWrap: true,
//           physics: ScrollPhysics(),
//           children: [
//             for(final tts in TransactionSummaryCtrl.lsData)
//             Card(
//               child: Column(
//                 children: [
//                   Text(tts?.type?.toString()??""),
//                   Text(tts?.net?.toString()??""),
//                   Text(tts?.qty?.toString()??"")
//                 ],
//               ), 
//             )
//           ],
//         )
//       ),
//     ],
//   );

// }

// class TransactionSummaryCtrl extends MyCtrl{
//   static final lsData = <ModelTransactionSummary>[].obs;
//   static final loading = false.obs;
//   static final loadingText = "loading ...".obs;
//   static final judul = "Transaction Summary".obs;

//   static Future init()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static getData()async{
//     final data = await RestApi.transactionSummary();
//     lsData.assignAll(data == null? 
//     List.filled(4, ModelTransactionSummary()): 
//     (data as List).map((e) => ModelTransactionSummary.fromJson(e)).toList());
//   }

// }