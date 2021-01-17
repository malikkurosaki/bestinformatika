import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoPaymentFb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("Payment".toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700]
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("type",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("value",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                  )
                ],
              ),
            ),
            GetX(
              initState: (state) => PaymentFbCtrl.mendapatkanPaymentFb('all'),
              builder: (controller) => PaymentFbCtrl.loadingFb.value?Center(child: CircularProgressIndicator(),):
              PaymentFbCtrl.lsFb.isEmpty?Center(child: Text("No Data Availabel"),):
              Container(
                child: Column(
                  children: [
                    for(var i = 0; i < PaymentFbCtrl.lsFb.length; i++)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(PaymentFbCtrl.lsFb[i]['id'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 24),
                          child: Card(
                            color: Colors.brown[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(PaymentFbCtrl.lsFb[i]['type'],),
                                Text(PaymentFbCtrl.lsFb[i]['value'],
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentFbCtrl extends PrestoCtrl{
  static final loadingFb = false.obs;
  static final lsFb = [].obs;

  static mendapatkanPaymentFb(String kode_out)async{
    loadingFb.value = true;
    
    try {
      if(GetStorage().hasData("payment")){
        lsFb.assignAll(GetStorage().read("payment"));
        loadingFb.value = false;
      }


      Response res = await ControllerApi.to.prestoPaymentFb(kode_out);
      final data = res.body['data']['data']??[];
      lsFb.assignAll(data);
      await GetStorage().write("payment", data);
    } catch (e) {
      print({
        "instance": "presto payment",
        "message": e.toString()
      });
    }
    loadingFb.value = false;
  }
}