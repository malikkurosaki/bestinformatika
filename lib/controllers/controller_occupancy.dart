import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerOccupancy extends GetxController{
  static ControllerOccupancy get to => Get.find();
  final loading = false.obs;
  final tunggu = false.obs;
  final occupancy = {}.obs;


  init()async{
    this.tunggu.value = true;
    this.loading.value = true;
    if(GetStorage().hasData('occupancy')){
      this.occupancy.assignAll(GetStorage().read('occupancy'));
      this.loading.value = false;
    }

    Response home = await ControllerApi().home();
    final occ = home.body['data']['data']['occupancy'];
    //await GetStorage().write("occupancy", occ);
    await GetStorage().write('occupancy', occ);
    this.occupancy.assignAll(occ??[]);
    this.loading.value = false;
    this.tunggu.value = false;
  }
}