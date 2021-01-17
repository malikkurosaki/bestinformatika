import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_api.dart';

class ControllerDailyMovement extends GetxController{
  static ControllerDailyMovement get to => Get.find();
  final loading = false.obs;
  // final roomSales = {}.obs;
  // final roomUnSold = {}.obs;
  // final revenue  = {}.obs;
  // final guest = {}.obs;
  // final roomRate = {}.obs;
  // final lenghtOfStay = {}.obs;
  // final reservationSummary = {}.obs;
  // final inHouseSummary = {}.obs;
  final movement = {}.obs;

  init() async {
    this.loading.value = true;
    if(GetStorage().hasData('movement')){
      this.loading.value = false;
      this.movement.assignAll(GetStorage().read('movement'));
    }

    Response data = await ControllerApi.to.home();
    final bahan = data.body['data']['data'];

    // final roomSales = bahan['roomSales'];
    // final roomUnSold = bahan['roomUnSold'];
    // final revenue = bahan['revenue'];
    // final guest = bahan['guest'];
    // final roomRate = bahan['roomRate'];
    // final lenghtOfStay = bahan['lenghtOfStay'];

    // this.roomSales.assignAll(bahan['roomSales']);
    // this.roomUnSold.assignAll(bahan['roomUnSold']);
    // this.revenue.assignAll(bahan['revenue']);
    // this.guest.assignAll(bahan['guest']);
    // this.roomRate.assignAll(bahan['roomRate']);
    // this.lenghtOfStay.assignAll(bahan['lenghtOfStay']);
    // this.reservationSummary.assignAll(bahan['reservationSummary']);
    // this.inHouseSummary.assignAll(bahan['inHouseSummary']);

    final paket = {
      'roomSales': bahan['roomSales'],
      'roomUnSold': bahan['roomUnSold'],
      'revenue': bahan['revenue'],
      'guest': bahan['guest'],
      'roomRate': bahan['roomRate'],
      'lenghtOfStay': bahan['lenghtOfStay'],
      'reservationSummary': bahan['reservationSummary'],
      'inHouseSummary': bahan['inHouseSummary']
    };

    print(paket['reservationSummary']);

    await GetStorage().write('movement', paket);
    this.movement.assignAll(paket??[]);
    this.loading.value = false;
  }
}