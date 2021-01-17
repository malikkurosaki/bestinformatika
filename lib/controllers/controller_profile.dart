import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class ControllerProfile extends GetxController{
  static ControllerProfile get to => Get.find();

  String getUserName() => GetStorage().hasData('auth')? GetStorage().read('auth')['data']['name']:"";

}