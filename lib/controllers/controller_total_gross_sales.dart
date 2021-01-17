import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerTotalGross extends GetxController{
  static ControllerTotalGross get to => Get.find();
  final loading = false.obs;
  final totalGross = {}.obs;

  init() async{
    this.loading.value = true;
    try {
      Response res = await ControllerApi.to.home();
      final data = res.body['data']['data'];
    } catch (e) {
    }
    this.loading.value = false;
  }
}