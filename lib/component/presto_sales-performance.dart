import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';

class PrestoSalesPerformance extends StatelessWidget {
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
              child: Text("Sales Performance",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700]
                ),
              ),
            ),
            GetX(
              initState: (state) => SalesPerformanceCtrl.init(),
              builder: (controller) => SalesPerformanceCtrl.loading2.value?Center(child: CircularProgressIndicator(),):
              GridView.count(crossAxisCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  for(var i = 0; i < SalesPerformanceCtrl.lsSales.length; i++)
                  Card(
                    color: SalesPerformanceCtrl.lsSales[i]['month'].toString() == PrestoCtrl.bln?Colors.orange[300]:Colors.orange[100],
                    child: Column(
                      children: [
                        Card(
                          color: Colors.orange[700],
                          child: Container(
                            width: double.infinity,
                            child: Center(
                              child: Text(SalesPerformanceCtrl.bulan[SalesPerformanceCtrl.lsSales[i]['month'] -1 ].toString().toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[100]
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Text(SalesPerformanceCtrl.lsSales[i]['value'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange[700]
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
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

class SalesPerformanceCtrl extends PrestoCtrl{
  static final loading2 = false.obs;
  static final lsSales = [].obs;
  static final bulan = [
    "jan",
    "feb",
    "mart",
    "aprl",
    "may",
    "jun",
    "jul",
    "ags",
    "sep",
    "okt",
    "nov",
    "des"
  ];

  static Future init()async{
    loading2.value = true;
    try {
      if(GetStorage().hasData("performance")){
        lsSales.assignAll(GetStorage().read("performance"));
        loading2.value = false;
      }

      Response res = await ControllerApi.to.prestoSalesPerformance(PrestoCtrl.to.kode_out.value);
      final List data  = res.body['data']['data']??[]; 
      lsSales.assignAll(data);
      //lsSales.assignAll(fake['data']['data']);
      await GetStorage().write("performance", lsSales);

      
    } catch (e) {
      print({
        "instanlce": "sales performance",
        "message": e.toString()
      });
    }
    loading2.value = false;
  }

  static final Map fake = {
    "response": 200,
    "message": "Sales Performance",
    "status": true,
    "param": {
      "outlet": "1"
    },
    "data": {
      "data": [
        {
          "month": 1,
          "value": "0"
        },
        {
          "month": 2,
          "value": "0"
        },
        {
          "month": 3,
          "value": "0"
        },
        {
          "month": 4,
          "value": "0"
        },
        {
          "month": 5,
          "value": "0"
        },
        {
          "month": 6,
          "value": "0"
        },
        {
          "month": 7,
          "value": "0"
        },
        {
          "month": 8,
          "value": "0"
        },
        {
          "month": 9,
          "value": "0"
        },
        {
          "month": 10,
          "value": "0"
        },
        {
          "month": 11,
          "value": "0"
        },
        {
          "month": 12,
          "value": "0"
        }
      ]
    }
  };

}