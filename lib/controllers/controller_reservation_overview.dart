import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller_api.dart';

class ControllerReservationOverview extends GetxController{
  static ControllerReservationOverview get to => Get.find();
  final loading = false.obs;
  final reservation = {}.obs;

  init() async {
    this.loading.value = true;
    if(GetStorage().hasData('paket_reservation_overview')){
      this.loading.value = false;
      this.reservation.assignAll(GetStorage().read('paket_reservation_overview'));
    }

    Response data = await ControllerApi.to.home();
    final bahan = data.body['data']['data'];

    final reservationSummary = bahan['reservationSummary'];
    final inHouseSummary = bahan['inHouseSummary'];

    final paket = {
      "a": reservationSummary,
      "b": inHouseSummary
    };

    await GetStorage().write("paket_reservation_overview", paket);

    this.reservation.assignAll(paket??[]);

    this.loading.value = false;
  }
}