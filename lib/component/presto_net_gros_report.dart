import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoNetgrossReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("net gros report".toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Today".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("Yesterday".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            NetGrosView()
          ],
        ),
      ),
    );
  }
}

class NetGrosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (state) => NetGrosReportCtrl.init(DateTime.now().toIso8601String().split("T")[0]),
      builder: (controller) => NetGrosReportCtrl.loading6.value?Center(child: CircularProgressIndicator(),):
      NetGrosReportCtrl.lsNetGross.isEmpty?Center(child: Text("No Data Aavailabel"),):
      Column(
        children: [
          for(var i = 0; i < NetGrosReportCtrl.lsNetGross.length; i++)
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(NetGrosReportCtrl.lsNetGross[i]['title'].toString().toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24),
                  child: Card(
                    color: Colors.orange[100],
                    
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(NetGrosReportCtrl.lsNetGross[i]['today'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                              fontSize: 18
                            ),
                          ),
                          Text(NetGrosReportCtrl.lsNetGross[i]['yesterday'].toString(),
                            style: TextStyle(
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NetGrosReportCtrl extends PrestoCtrl{
  static final loading6 = false.obs;
  static final lsNetGross = [].obs;

  static init(String date)async{
    loading6.value = true;
    try {
      if(GetStorage().hasData("gross")){
        lsNetGross.assignAll(GetStorage().read("gross"));
        loading6.value = false;
      }

      Response res = await ControllerApi.to.prestoNetgross(date);
      final data = res.body['data']['data']??[];
      lsNetGross.assignAll(data);
      await GetStorage().write("gross", data);
    } catch (e) {
      print({
        "instance": "net gross",
        "message": e.toString()
      });
    }
    loading6.value = false;
  }
}