import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoHomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Home".toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown
              ),
            ),
            GetX(
              initState: (state) => PrestoDashboardController.mengambilDashboard(PrestoCtrl.to.kode_out.value),
              builder: (controller) => PrestoDashboardController.meloading.value?Center(child: CircularProgressIndicator(),):
              PrestoDashboardController.lsDashboard.isEmpty?Center(child: Text("No Data Availabel"),):
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: [
                  for(var i = 0; i < PrestoDashboardController.lsDashboard.length; i++)
                  Card(
                    color: i % 2 == 0?Colors.brown[100]: Colors.brown[300],
                    child: Column(
                      children: [
                        Flexible(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("today"),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(PrestoDashboardController.lsDashboard[i]['today'].toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.brown
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )
                          )
                        ),
                        Column(
                          children: [
                            Text("yesterday"),
                            Text(PrestoDashboardController.lsDashboard[i]['yesterday'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(4),
                            child: Text(PrestoDashboardController.lsDashboard[i]['title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.brown
                              ),
                            )
                          )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrestoDashboardController extends PrestoCtrl{
  static final lsDashboard = [].obs;
  static final meloading = false.obs;

  static mengambilDashboard(String kode_out)async{
    meloading.value = true;
    try {
      if(GetStorage().hasData("presto_home")){
        lsDashboard.assignAll(GetStorage().read("presto_home"));
        meloading.value = false;
      }

      Response res = await ControllerApi.to.prestoHomeindex(kode_out);
      final data = res.body['data']['data']??[];
      lsDashboard.assignAll(data);
      await GetStorage().write("presto_home", data);
    } catch (e) {
      print("presto Home "+e.toString());
    }
    meloading.value = false;
  }
}