import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerByCountry extends GetxController{
  static ControllerByCountry get to => Get.find();
  final loading = false.obs;
  final byCountry = [].obs;

  init() async {
    this.loading.value = true;
    if(GetStorage().hasData("by_country")){
      this.loading.value = false;
      this.byCountry.assignAll(GetStorage().read('by_country'));
    }

    final fake = [
      {
        "country": "Russia",
        "value": 3
      },
      {
        "country": "Indonesia",
        "value": 1
      }
    ];

    try {
      Response res = await ControllerApi.to.roomProductionByCountry();
      final List data = res.body['data']['data'];
      this.byCountry.assignAll(data??[]);
      if(data.isNotEmpty){
        await GetStorage().write("by_country", data);
      }
      //print(data);
    } catch (e) {
      print("by coutry : "+ e);
    }

    this.loading.value = false;
  }


}