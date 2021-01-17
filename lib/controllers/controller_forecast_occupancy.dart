import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerForecastOccupancy extends GetxController{
  static ControllerForecastOccupancy get to => Get.find();
  final loading = false.obs;
  final forecast = [].obs;
  final List namaBulan = [
    "january",
    "february",
    "maret",
    "april",
    "mei",
    "juni",
    "juli",
    "agustus",
    "september",
    "oktober",
    "november",
    "desember"
  ];

  init() async{
    this.loading.value = true;
    if(GetStorage().hasData('forecast')) {
      this.loading.value = false;
      this.forecast.assignAll(GetStorage().read('forecast'));
    }
    try {
      Response res = await ControllerApi.to.foreCastOcupancy();
      final List data = res.body['data']['data'];

      this.forecast.assignAll(data??[]);
      if(data.isNotEmpty ) await GetStorage().write("forecast", data);

    } catch (e) {
      this.loading.value = false;
      print("controller forecast occupancy : "+ e);
    }
    this.loading.value = false;
  }

}