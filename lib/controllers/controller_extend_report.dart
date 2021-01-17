
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class ControllerExtenReportOverview extends GetxController{
  static ControllerExtenReportOverview get to => Get.find();
  final index = 0.obs;
  final today = [].obs;
  final tomorrow = [].obs;
  final loading = false.obs;

  init(){
    this.loading.value = true;
    if(GetStorage().hasData("report_data")){
      final data = GetStorage().read('report_data');
      this.today.assignAll(data['data']??[]);
      this.tomorrow.assignAll(data['dataT']??[]);
      
    }
    this.loading.value = false;
  }

  lihatIndex(i){
    this.index.value = i;
  }
}