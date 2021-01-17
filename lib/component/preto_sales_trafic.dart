import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoSalaesTrafic extends StatelessWidget {
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
              child: Text("sales trafic".toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.lime[900]
                ),
              ),
            ),
            GetX(
              initState: (state) => SalesTraficCtrl.init(PrestoCtrl.to.kode_out.value),
              builder: (controller) => SalesTraficCtrl.loading4.value?Center(child: CircularProgressIndicator(),):
              SalesTraficCtrl.lsTrafic.isEmpty?Center(child: Text("No Data Available"),):
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for(var i = 0; i < SalesTraficCtrl.lsTrafic.length; i++)
                  Card(
                    color: DateFormat('EEEE').format(DateTime.now()).toString().toLowerCase() == SalesTraficCtrl.lsTrafic[i]['date'].toString().toLowerCase()?Colors.lime[300]:Colors.lime[100],
                    child: Column(
                      children: [
                        Card(
                          //color: Colors.orange[i < 9?(i +1) * 100:900],
                          color: Colors.lime[900],
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(SalesTraficCtrl.lsTrafic[i]['date'].toString().toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lime[100]
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: Center(
                              child: Text(SalesTraficCtrl.lsTrafic[i]['value'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lime[900]
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ),
                          )
                        )
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

class SalesTraficCtrl extends PrestoCtrl{
  static final loading4 = false.obs;
  static final lsTrafic = [].obs;

  static init(String kode_out)async{
    loading4.value = true;
    try {
      if(GetStorage().hasData("trafic")){
        lsTrafic.assignAll(GetStorage().read("trafic"));
        loading4.value = false;
      }

      Response res = await ControllerApi.to.prestoSalesTrafic(kode_out);
      final data = res.body['data']['data']??[];
      lsTrafic.assignAll(data);
      await GetStorage().write("trafic", data);
    } catch (e) {
      print({
        "instance": "presto sales trafic",
        "message": e.toString()
      });
    }

    loading4.value = false;
  }


}