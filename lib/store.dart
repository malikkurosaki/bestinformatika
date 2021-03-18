import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

import 'models_phis/model_user_data.dart';

extension Store on GetStorage{
  static bool sudahLogin() => GetStorage().hasData('token');

  static void logOut()async{
    await GetStorage().remove("token");
    Get.offNamed("/");
  }

  static ModelUserData userData() => ModelUserData.fromJson( GetStorage().read("userData"));
  static String get token => GetStorage().read("token");
  static String get outletId => GetStorage().read("outlet_id").toString();
  static Map<String, String> get headers => {"Authorization": "Bearer "+GetStorage().read("token")};

  static String get tipe => GetStorage().read("type")??"DTD";
  static Future<void> setTipe(String value)async => await GetStorage().write("type", value);

  static String get date => GetStorage().read("date")??DateTime.now().toString().split(" ")[0];
  static Future<void> setDate(String value) async => await GetStorage().write("date", value);

  static String get noRes => GetStorage().read("no_res");
  static Future<void> setNoRes(String value) async => GetStorage().write("no_res", value);

  static String get dept => GetStorage().read("dept")??"all";
  static Future<void> setDept(String value) async => GetStorage().write("dept", value);

  static String get kodeOut => GetStorage().read("kode_out")??"all";
  static Future<void> setKodeout(String value) async => GetStorage().write("kode_out", value);

  // static String get departement => GetStorage().read("departement");
  // static Future<void> setDepartement(String value) async => GetStorage().write("departement", value);

  static String get group => GetStorage().read("group")??"FOOD";
  static Future<void> seGroup(String value) async => GetStorage().write("group", value);

}

class Suara{
  static final soundPool = Soundpool();
  // static final swipePool = Soundpool();
  // static final waterPool = Soundpool();

  static int soundId;
  static int swipeId;
  static int waterId;
  static int waterId2;

  static init()async{
    soundId = await rootBundle.load("assets/sound/paper.wav",).then((ByteData soundData) => soundPool.load(soundData));
    swipeId = await rootBundle.load("assets/sound/paper2.wav").then((ByteData soundData) => soundPool.load(soundData));
    waterId = await rootBundle.load("assets/sound/swipe2.wav").then((ByteData soundData) => soundPool.load(soundData));
    waterId2 = await rootBundle.load("assets/sound/water2.wav").then((ByteData soundData) => soundPool.load(soundData));

    soundPool.setVolume(soundId: soundId, volume: 0.4);
    soundPool.setVolume(soundId: swipeId, volume: 0.4);
    soundPool.setVolume(soundId: waterId, volume: 0.4);
    soundPool.setVolume(soundId: waterId2, volume: 0.4);
  }
}



