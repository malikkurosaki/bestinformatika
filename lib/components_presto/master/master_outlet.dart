import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/models_presto/model_master_outlet.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';
import '../../store.dart';

class MasterOutlet extends TemplateData<ModelMaterOutlet>{
  final lihat = ValueNotifier(Store.kodeOut);

  final OnDipilih onDipilih;
  MasterOutlet(this.onDipilih);

  @override
  Widget build(BuildContext context) => olah((hasil) => 
    TextButton(
      onPressed: () => Get.bottomSheet(
        DraggableScrollableSheet(
          builder: (context, scrollController)  => 
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Flexible(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    controller: scrollController,
                    children: [
                      for(final ls in hasil)
                      ListTile(
                        title: Text(ls.namaOut),
                        onTap: () async{
                          onDipilih();
                          lihat.value = ls.namaOut;
                          await Store.setKodeout(ls.kodeOut);
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ), 
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Outlet Type ").biasa,
          ValueListenableBuilder(
            valueListenable: lihat, 
            builder: (context, value, child) => 
            Text(value).boldUpper,
          ),
          Icon(Icons.arrow_drop_down)
        ],
      )
    )
  );

  @override
  Future getData()async {
    
    Response res = await RestApi.masterOutlet();
    if(res.body is Map){
      final List data = (res.body['data']['data'] as List);
      lsData.assignAll(
        data.isEmpty?
        RestRestponseRestaurant.masterOutlet.map((e) => ModelMaterOutlet.fromJson(e)).toList():
        data.map((e) => ModelMaterOutlet.fromJson(e)).toList()
      );
    }
   
  }
}
