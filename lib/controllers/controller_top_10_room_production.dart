import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerTop10RoomProduction extends GetxController{
  static ControllerTop10RoomProduction get to => Get.find();
  final loading = false.obs;
  final top10room = [].obs;

  init()async{
    this.loading.value = true;
    if(GetStorage().hasData('top10room')){
      this.top10room.assignAll(GetStorage().read('top10room')??[]);
      this.loading.value = false;
    }

    try {
      Response res = await ControllerApi.to.roomProduction();
      this.top10room.assignAll(res.body['data']['data']??[]);
      await GetStorage().write('top10room', res.body['data']['data']);
    } catch (e) {
      print("controller top 10 room production "+ e);
    }

    this.loading.value = false;
  }
}

