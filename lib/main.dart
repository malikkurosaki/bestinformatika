import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';
import 'package:probus_mobile/views/home.dart';
import 'package:probus_mobile/views/hotel.dart';
import 'package:probus_mobile/views/login.dart';
import 'package:probus_mobile/views/restaurant.dart';


void main() async{
  Get.put<MyCtrl>(MyCtrl());
  await GetStorage.init();
  Suara.init();
  runApp(MyApp());
}

// class The extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: MaterialApp(
//         home: Scaffold(
//           body: Text("ya ini"),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetMaterialApp(
        // initialBinding: MyBinnding(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => RootView()),
          GetPage(name: "/login", page: () => Login()),
          GetPage(name: "/home", page: () => Home()),
          GetPage(name: "/hotel", page: () => Hotel(), transitionDuration: Duration(milliseconds: 700)),
          GetPage(name: "/restaurant", page: () => Restaurant(), transitionDuration: Duration(milliseconds: 700))
        ],
      )
    );
  }
}

class MyBinnding extends Bindings{
  @override
  void dependencies() {
    
  }

}

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: RootCtrl.init(),
            builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done?
            Text("splash screen"): Text("Splash Screen"),
          ),
        ),
      ),
    );
  }
}

class RootCtrl {
  static init()async{
    await Future.delayed(Duration(seconds: 2));
    Store.sudahLogin()? Get.offNamed('/home'): Get.offNamed("/login");
  }
}

