import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:probus_mobile/models_presto/model_sales_analisys_by_time_order.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';

import 'master/master_date.dart';
import 'master/master_dept.dart';
import 'master/master_tipe.dart';


class SalesAnalisysByTimeOrder extends Bantuan{
  static final lsData = <ModelSalesAnalisysByTimeOrder>[].obs;
  static final load = false.obs;
  final bool denganJudul;

  SalesAnalisysByTimeOrder({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul??false,
    onFinis: () => 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: Colors.grey[100],
          child: Wrap(
            children: [
              MasterDate((_) => init()),
              MasterDept((_) => init()),
              MasterTipe(
                hasil: (_) => init(), 
                lsTipe: ["DTD", "YTD"]
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: GridView.count(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            crossAxisCount: 3,
            children: [
              for(final ls in lsData)
              Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        color: Colors.blueGrey[400],
                        height: 35,
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        child: Text(ls?.label?.toString()??"").boldPutih
                      ),
                      Expanded(
                        child: FlipCard(
                          direction: FlipDirection.VERTICAL,
                          front: depan(ls), 
                          back: belakang(ls)
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(top: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for(final ls in List.filled(6, ""))
                        Card(
                          color: Colors.blueGrey[800],
                          child: Container(
                            width: 5,
                            height: 20,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    )
  );
  
  @override
  void datanya(theData) {
    lsData.assignAll(
      theData == null? RestRestponseRestaurant.salesAnalisysByTimeOrder.map((e) => ModelSalesAnalisysByTimeOrder.fromJson(e)).toList():
      (theData as List).map((e) => ModelSalesAnalisysByTimeOrder.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.salesAnalysisTime();

  @override
  String get title => "Sales Analisys By Time Order";


  Widget depan(ModelSalesAnalisysByTimeOrder ls) => 
  Container(
    color: Colors.blueGrey[100],
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.all(4),
    width: double.infinity,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.fastfood_outlined,
            color: Colors.white38,
            size: 53,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  width: 50,
                  child: Text("Start").bold
                ),
                Text(ls?.start?.toString()??""),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  width: 50,
                  child: Text("Finish").bold
                ),
                Text(ls?.finish?.toString()??""),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  width: 50,
                  child: Text("Value").bold
                ),
                Text(ls?.value?.toString()??""),
              ],
            )
          ],
        ),
      ],
    ),
  );

  Widget belakang(ModelSalesAnalisysByTimeOrder ls) =>
  Container(
    color: Colors.blueGrey[100],
    margin: EdgeInsets.all(2),
    padding: EdgeInsets.all(4),
    width: double.infinity,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Icon(
            Icons.fastfood_outlined,
            color: Colors.white38,
            size: 53,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  width: 50,
                  child: Text("Start").bold
                ),
                Text(ls?.start?.toString()??""),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  width: 50,
                  child: Text("Finish").bold
                ),
                Text(ls?.finish?.toString()??""),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  width: 50,
                  child: Text("Value").bold
                ),
                Text(ls?.value?.toString()??""),
              ],
            )
          ],
        ),
      ],
    ),
  );

}
