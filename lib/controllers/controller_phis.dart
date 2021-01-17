import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerPhis extends GetxController{
  static ControllerPhis get to => Get.find();
  final occupancy = {}.obs;

  Future getOccupancy() async {
    final occupancy = await ControllerApi().home();

  }

}