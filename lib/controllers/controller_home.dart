
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
class ControllerHome extends GetxController{
  static ControllerHome get to => Get.find();
  final ambilData = true.obs;
  final loading = "loading...";

  void keProfile(){
    Get.toNamed('/profile');
  }

  void kePhis()async{
    Get.toNamed('/phis');
  }

  void kePresto(){
    Get.toNamed('/presto');
    
  }

  List getListCompeny(){
    final com = GetStorage().read('auth')['data']['company'];
    return com;
  } 

  void kePhisPage(Map outlet,String type) async {

    final auth = await GetStorage().read('auth');
    await GetStorage().write('outlet', outlet);
    await GetStorage().write('id', outlet['id']);
    PrestoCtrl.to.property_name.value = outlet['name'];
    
    try {
      switch(type.toString().trim()){
        case "Hotel":
          try {
            Get.toNamed('/phis');
          } catch (e) {
            Get.snackbar("Info", "data is empty or no connections");
          }
        break;
        case "Restaurant":
          try {
            Get.toNamed('/presto');
          } catch (e) {
            Get.snackbar("Info", "data is empty or no connections");
          }
        break;
      }
    } catch (e) {
      print("home : "+ e);
    }
  }
}