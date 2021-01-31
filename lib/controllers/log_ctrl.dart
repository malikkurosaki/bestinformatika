import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class LogCtrl extends GetxController{
  static final lsLog = [].obs;
  static add(String log){
    final waktu = DateTime.now();
    final data = "$waktu : $log";
    lsLog.add(data);
  }
}