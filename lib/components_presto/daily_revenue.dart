import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/models_presto/model_dayly_revenue.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';

import 'master/master_date.dart';
import 'master/master_dept.dart';

class DailyRevenue extends Bantuan{
  static final lsData = <ModelDailyRevenue>[].obs;
  static final load = false.obs;
  final bool denganJudul;

  DailyRevenue({this.denganJudul});

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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Card(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: Text("Name").bold,
                          ),
                          Container(
                            width: 70,
                            child: Text("Today").bold,
                          ),
                          Container(
                            width: 70,
                            child: Text("Ytd").bold,
                          ),
                          Container(
                            width: 70,
                            child: Text("Mtd").bold,
                          ),
                          Container(
                            width: 70,
                            child: Text("Ltd").bold,
                          ),
                        ],
                      ),
                    ),
                    for(final ls in lsData)
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.1, color: Colors.blue))
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            width: 150,
                            child: Text(ls.title.toString(),
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                          Container(
                            width: 70,
                            child: Text(ls.today.toString())
                          ),
                          Container(
                            width: 70,
                            child: Text(ls.ytd.toString())
                          ),
                          Container(
                            width: 70,
                            child: Text(ls.mtd.toString())
                          ),
                          Container(
                            width: 70,
                            child: Text(ls.lmd.toString())
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.add_business_sharp,
                size: 128,
                color: Colors.black12,
              ),
            ],
          ),
        )
      ],
    )
  );

  @override
  void datanya(theData) {
    lsData.assignAll(
      theData == null? RestRestponseRestaurant.dailyRevenue.map((e) => ModelDailyRevenue.fromJson(e)).toList():
      (theData as List).map((e) => ModelDailyRevenue.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.dailyRevenue();

  @override
  String get title => "Daily Revenue";
}

// class DailyRevenue extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) => 
//   Container(
//     margin: EdgeInsets.only(top: 16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           child: Text(DailyRevenueCtrl.judul.value).judul
//         ),
//         Wrap(
//           children: [
//             Container(
//               color: Colors.grey[300],
//               child: MasterDate((_) => DailyRevenueCtrl.init()),
//             ),
//             Container(
//               color: Colors.grey[300],
//               child: MasterDept((_) => DailyRevenueCtrl.init()),
//             ),
//           ],
//         ),
//         GetX(
//           initState: (state) => DailyRevenueCtrl.init(),
//           builder: (controller) => 
//           DailyRevenueCtrl.loading.value? 
//           Text(DailyRevenueCtrl.loadingText.value): 
//           GridView.count(
//             crossAxisCount: 4,
//             physics: ScrollPhysics(),
//             shrinkWrap: true,
//             children: [
//               for(final dal in DailyRevenueCtrl.lsData)
//               Card(
//                 child: Column(
//                   children: [
//                     Text(dal?.title?.toString()??""),
//                     Text(dal?.today?.toString()??""),
//                     Text(dal?.ytd?.toString()??""),
//                     Text(dal?.lmd?.toString()??"empty data").biasa,
//                   ],
//                 ),
//               )
//             ],
//           )
//         ),
//       ],
//     ),
//   );

// }

// class DailyRevenueCtrl extends MyCtrl{
//   static final lsData = <ModelDailyRevenue>[].obs;
//   static final loading = false.obs;
//   static final loadingText = "loaading ...".obs;
//   static final judul = "Daily Revenue".obs;

//   static init ()async{
//     loading.value = true;
//     await getData();
//     loading.value = false;
//   }

//   static Future getData()async{
//     if(GetStorage().hasData(judul.value)){
//       loading.value = false;
//     }
//     final data = await RestApi.dailyRevenue();
//     lsData.assignAll(data == null ? 
//     List.filled(4, ModelDailyRevenue()): 
//     (data as List).map((e) => ModelDailyRevenue.fromJson(e)).toList());
//   }
// }