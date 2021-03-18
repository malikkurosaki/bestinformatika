import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';

typedef HasilGroup<T> = Function(String value);
class MasterGroupProduct extends Bantuan{
  static final lsData = [].obs;
  static final load = false.obs;
  static final pilihan = Store.group.obs;
  final HasilGroup hasilGroup;


  final masterPro = [
    "FOOD",
    "BEVERAGE",
    "SPA",
    "LAUNDRY",
    "TRANSPORTATION",
    "OTHERS"
  ];

  MasterGroupProduct(this.hasilGroup);

  @override
  Widget build(BuildContext context) => buat(
    denganJudul: false,
    onFinis: () => 
    TextButton(
      onPressed: () => Get.bottomSheet(kemunculan(lsData)), 
      child: Row(
        children: [
          Text("Group Type ").biasa,
          Text(pilihan.value).bold,
          Icon(
            Icons.arrow_drop_down
          )
        ],
      )
    ), 
    
  );
  
  @override
  void datanya(theData) {
    lsData.assignAll(
      theData == null? masterPro:
      theData
    );
  }

  @override
  Future get restApi => RestApi.masterGroupProduct();

  @override
  String get title => "Master Group";


  Widget kemunculan(List hasil) =>
  DraggableScrollableSheet(
    builder: (context, scrollController) => 
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(),
          Flexible(
            child: ListView(
              controller: scrollController,
              children: [
                for(final ls in  hasil)
                ListTile(
                  title: Text(ls),
                  onTap: ()async{
                    pilihan.value = ls;
                    hasilGroup(ls);
                    await Store.seGroup(ls);
                    Get.back();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );

 
  // final HasilGroup hasilGroup;
  // final lihat = ValueNotifier(Store.group);

  // MasterGroupProduct(this.hasilGroup);

  // @override
  // Widget build(BuildContext context) => olah((hasil) => 
  //   InkWell(
  //     onTap: () => 
  // Get.bottomSheet(
  //       DraggableScrollableSheet(
  //         builder: (context, scrollController) => 
  //         Card(
  //           child: ListView(
  //             controller: scrollController,
  //             children: [
  //               for(final ls in  hasil)
  //               ListTile(
  //                 title: Text(ls),
  //                 onTap: ()async{
  //                   lihat.value = ls;
  //                   hasilGroup(ls);
  //                   await Store.seGroup(ls);
  //                   Get.back();
  //                 },
  //               )
  //             ],
  //           ),
  //         ),
  //       )
  //     ), 
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Text("Group Type ").biasa,
  //         ValueListenableBuilder(
  //           valueListenable: lihat, 
  //           builder: (context, value, child) => 
  //           Text(value).boldUpper,
  //         ),
  //         Icon(Icons.arrow_drop_down)
  //       ],
  //     )
  //   )
  // );

  // final masterPro = [
  //   "FOOD",
  //   "BEVERAGE",
  //   "SPA",
  //   "LAUNDRY",
  //   "TRANSPORTATION",
  //   "OTHERS"
  // ];

  // @override
  // Future getData()async {
  //   Response res = await RestApi.masterGroupProduct();
    
  //   if(res.body is Map){
  //     print(res.body);
  //     final data = (res.body['data']['data'] as List);
  //     lsData.assignAll(
  //       data.isEmpty? masterPro:
  //       data
  //     );
  //     Store.seGroup(res.body['data']['data']);
  //   }
  // }

}