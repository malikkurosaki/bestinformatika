

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/models_phis/model_user_data.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: FutureBuilder(
          future: HomeCtrl.init(),
          builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done?
          Text("loading"):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      child: Image.asset("assets/images/plan.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(HomeCtrl.userData.value.data.name,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 32,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(final com in HomeCtrl.userData.value.data.company)
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25,
                                      ),
                                      CircleAvatar(
                                        radius: 23,
                                        backgroundImage: NetworkImage(com.logo,),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(com.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w100
                                      ),
                                    )
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  for(final pro in com.properties)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Icon(pro.type == "Hotel"?Icons.home_outlined: Icons.fastfood),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: Text(pro.type,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      for(final ot in pro.outlets)
                                      Card(
                                        color: Colors.blue,
                                        child: InkWell(
                                          onTap: () async{
                                            await GetStorage().write("hero", ot.id);
                                            await GetStorage().write("hero_image", ot.logoUrl);
                                            await GetStorage().write("hero_name", ot.name);
                                            await GetStorage().write("outlet_id", ot.id);

                                            // await Store.setDepartement(ot.name);

                                            //print(ot.toJson().toString());

                                            Get.toNamed('/${pro.type.toLowerCase()}');
                                          },
                                          child: Container(
                                            width: Get.width / 4,
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  child: Hero(
                                                    tag: ot.id,
                                                    child: Image.network(ot.logoUrl,
                                                      fit: BoxFit.cover,
                                                      height: Get.width / 4,
                                                    ),
                                                  )
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  child: Text(ot.name,
                                                  overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w100
                                                    ),
                                                  )
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                )
              )
            ],
          )
        )
      ),
    );
  }
}

class HomeCtrl extends MyCtrl{
  static final  userData = ModelUserData().obs;

  static init()async{
    userData.value = Store.userData();
  }
}