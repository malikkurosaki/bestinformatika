import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/console_log.dart';

class ControllerSplash extends GetxController {
  static ControllerSplash get to => Get.find();

  final splash = false.obs;

  void mulaiSplash()async{
    await Future.delayed(Duration(seconds: 2));
    splash.value = true;
    console.log(splash.value);

    if(GetStorage().hasData('auth')){
      Get.offAndToNamed('/home');
    }else{
      Get.offAndToNamed('/login');
    }
  }
  
}