import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/controller_extend_report.dart';
import 'package:get/get.dart';

class DetailsReport extends StatelessWidget {
  final nores;
  final scrl = ScrollController();
  DetailsReport({Key key, this.nores}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DraggableScrollableSheet(
        builder: (context, scrollController) => Card(
          child: Container(
            padding: EdgeInsets.all(8),
            child: GetX(
              initState: (state) => DetailsControllers.ambilDataPerformaInfoice(nores),
              builder: (controller) => !DetailsControllers.meloading.value?SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  height: double.parse((DetailsControllers.lsPerforma.length*50).toString()),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black26,
                          child: Row(
                            children: [
                              for(var e = 0; e < DetailsControllers.listDetail.length; e++)
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.black12,
                                margin: EdgeInsets.only(right: 4),
                                width: e == 3 || e == 4?200:100,
                                child: Text(DetailsControllers.listDetail[e].toString().replaceAll("_", " ").toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        for(var a = 0; a < DetailsControllers.lsPerforma.length; a++)
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for(var s = 0; s < DetailsControllers.listDetail.length; s++)
                              Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.black12,
                                margin: EdgeInsets.only(right: 4, bottom: 4),
                                width: s == 3 || s == 4?200:100,
                                child: Text(DetailsControllers.lsPerforma[a][DetailsControllers.listDetail[s]].toString(),
                                  overflow: TextOverflow.ellipsis,
                                )
                              )
                              // Text(DetailsControllers.lsPerforma[a]['day']),
                              // Text(DetailsControllers.lsPerforma[a]['date']),
                              // Text(DetailsControllers.lsPerforma[a]['room']),
                              // Text(DetailsControllers.lsPerforma[a]['room_name']),
                              // Text(DetailsControllers.lsPerforma[a]['nores']),
                              // Text(DetailsControllers.lsPerforma[a]['season']),
                              // Text(DetailsControllers.lsPerforma[a]['kd_jenis']),
                              // Text(DetailsControllers.lsPerforma[a]['nm_jenis']),
                              // Text(DetailsControllers.lsPerforma[a]['room_price']),
                              // Text(DetailsControllers.lsPerforma[a]['extrabed']),
                              // Text(DetailsControllers.lsPerforma[a]['extrabed_price']),
                              // Text(DetailsControllers.lsPerforma[a]['total_amount']),
                              // Text(DetailsControllers.lsPerforma[a]['sortdate']),
                              // Text(DetailsControllers.lsPerforma[a]['formatrdate'])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ): Center(child: CircularProgressIndicator(),),
            )
          ),
        ),
      ),
    );
  }
}


class DetailsControllers extends ControllerExtenReportOverview{
  static final meloading = false.obs;
  static final lsPerforma = [].obs;
  static final listDetail = [].obs;

  static ambilDataPerformaInfoice(String nores)async{
    meloading.value = true;

    Response data  = await ControllerApi.to.performaInvoice(nores);
    final listnya = data.body['data']['data'];
    lsPerforma.assignAll(listnya);
    meloading.value = false;
    listDetail.assignAll(listnya[0].keys.toList());
  }
}