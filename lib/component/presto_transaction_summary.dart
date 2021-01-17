import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoTransactionSummary extends StatelessWidget {
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
              child: Text("Transaction Summary",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown
                ),
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("qty".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text('net'.toUpperCase(),
                     style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  )
                ],
              ),
            ),
            GetX(
              initState: (_) => TransactionSummaryCtrl.init("all"),
              builder: (controller) => TransactionSummaryCtrl.loading1.value?Center(child: CircularProgressIndicator(),):
              TransactionSummaryCtrl.lsSumary.isEmpty?Center(child: Text("No Data Available"),):
              Column(
                children: [
                  for(var i = 0; i < TransactionSummaryCtrl.lsSumary.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TransactionSummaryCtrl.lsSumary[i]['type'].toString().toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 24),
                        child: Card(
                          color: Colors.brown[100],
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(TransactionSummaryCtrl.lsSumary[i]['qty'].toString(),
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                                Text(TransactionSummaryCtrl.lsSumary[i]['net'].toString()),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionSummaryCtrl extends PrestoCtrl{
  static final loading1 = false.obs;
  static final lsSumary = [].obs;

  static Future init(String kode_out)async{
    loading1.value = true;

    try {

      if(GetStorage().hasData("summary")){
        lsSumary.assignAll(GetStorage().read("summary"));
        loading1.value = false;
      }
      
      Response res = await ControllerApi.to.prestoTransactionSummary(kode_out);
      final data = res.body['data']['data'];
      lsSumary.assignAll(data);
      await GetStorage().write("summary", data);

    } catch (e) {
      print({
        "instance": "transaction summary",
        "message": e.toString()
      });
    }

    loading1.value = false;
  }
}