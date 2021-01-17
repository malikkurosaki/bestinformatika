

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';


class ControllerByCity extends GetxController{
  static ControllerByCity get to => Get.find();
  final loading = false.obs;
  final byCity = [].obs;
  

  init() async {
    final fake = [
      {
        "city": "polandia",
        "value": 4
      },
      {
        "city": "argentina",
        "value": 4
      }
    ];

    this.loading.value = true;
    if(GetStorage().hasData('by_city')){
      this.loading.value = false;
      this.byCity.assignAll(GetStorage().read('by_city'));
    }

    try {
      Response res = await ControllerApi.to.roomProductionByCity();
      List data = res.body['data']['data'];
      this.byCity.assignAll(data??[]);
      if(data.isNotEmpty) await GetStorage().write('by_city', data);

    } catch (e) {
      this.loading.value = false;
      print(" by city : "+ e);
    }
    this.loading.value = false;
  }

  

}