import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/components_presto/master/master_date.dart';
import 'package:probus_mobile/components_presto/master/master_dept.dart';
import 'package:probus_mobile/components_presto/master/master_tipe.dart';
import 'package:probus_mobile/components_presto/master/mater_group_product.dart';
import 'package:probus_mobile/models_presto/model_product_sales.dart';
import 'package:probus_mobile/rest_api.dart';
import 'package:probus_mobile/rest_response_restaurant.dart';
import 'package:probus_mobile/tema.dart';


class ProductSales extends Bantuan{
  static final lsData = <ModelProductSales>[].obs;
  static final load = false.obs;
  final bool denganJudul;
  static final toogle = false.obs;

  ProductSales({this.denganJudul});

  @override
  Widget build(BuildContext context) =>
  buat(
    denganJudul: denganJudul??false,
    onFinis: () => 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[100],
          child: Wrap(
            children: [
              MasterDate((_) => init()),
              MasterDept((_) => init()),
              MasterTipe(
                hasil: (_) => init(), 
                lsTipe: ["DTD", "MTD", "YTD"]
              ),
              MasterGroupProduct(
                (_) => init()
              )
            ],
          ),
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            for(final ls in lsData)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(4),
                    color: Colors.amber,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: toogle.value? Alignment.topLeft: Alignment.topRight,
                              end: toogle.value? Alignment.bottomLeft: Alignment.topLeft,
                              colors: [
                                toogle.value?Colors.yellow: Colors.amber,
                                toogle.value?Colors.amber: Colors.orange[900]
                              ]
                            )
                          ),
                        ),
                        Icon(
                          Icons.food_bank,
                          size: 64,
                          color: Colors.white24,
                        ),
                        InkWell(
                          onTap: () => toogle.value = !toogle.value,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(ls?.qty?.toString()??"").judulBoldPutih,
                                  )
                                ),
                                Row(
                                  children: [
                                    Text("Price : ").bold,
                                    Text(ls?.price?.toString()??"")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Total : ").bold,
                                    Text(ls?.total?.toString()??"")
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(ls?.name?.toString()??"").bold,
                )
              ],
            )
          ],
        )
      ],
    )
  );
  
  @override
  void datanya(theData) {
    print(theData);
    lsData.assignAll(
      theData == null? RestRestponseRestaurant.productSales.map((e) => ModelProductSales.fromJson(e)).toList():
      (theData as List ).map((e) => ModelProductSales.fromJson(e)).toList()
    );
  }

  @override
  RxBool get loading => load;

  @override
  Future get restApi => RestApi.productSales();

  @override
  String get title => "Product Sales";

}

