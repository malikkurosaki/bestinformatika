import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_api.dart';


class ControllerLogin extends GetxController{
  static ControllerLogin get to => Get.find();
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  final sudah = true.obs;
  final sudahLogout = true.obs;


  void cobaLogin()async {
    // testing
    email.value.text = "administrator@app.com";
    password.value.text = "123456";

    sudah.value = false;
    console.log("${email.value.text} > ${password.value.text}");
    if(email.value.text.isEmpty || password.value.text.isEmpty){
      Get.snackbar("empty", "no empty for email or password");
      sudah.value = true;
      return;
    }

    if(!email.value.text.isEmail){
      Get.snackbar("email", "please insert true email format");
      sudah.value = true;
      return;
    }

    final paket = {
      "email": email.value.text,
      "password": password.value.text
    };

    Response res = await ControllerApi().login(paket);
    final data = res.body;

    // print({
    //   "instance": "login controller",
    //   "data": data
    // });
    
    if(data['status']){
        await GetStorage().write('auth', data['data']);
        await GetStorage().write('token', data['data']['token']);
        
        sudah.value = true;
        Get.offAndToNamed('/');
    }else{
      sudah.value = true;
      console.log("login status false");
      Get.snackbar("info", "wrong email or password");
    }
  }

  logout()async{
    sudahLogout.value = false;
    GetStorage().erase();
    await Future.delayed(Duration(seconds: 2));
    sudahLogout.value = true;
    Get.offAndToNamed('/');
  }


}