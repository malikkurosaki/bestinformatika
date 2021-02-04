import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:probus_mobile/controllers/controller_extend_report.dart';
import 'package:get/get.dart';

import 'detail_expanded_report.dart';

class ExtendReportTomorrow extends GetView<ControllerExtenReportOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.loading.value?
      LoadingReportTomorrow(): DetailReportTomorrow(data: controller.tomorrow,),
    );
  }
}

class LoadingReportTomorrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DetailReportTomorrow extends StatelessWidget {
  final RxList data;

  const DetailReportTomorrow({Key key, this.data}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/tomorrow.jpg')
              )
            ),
            height: 100,
            child: Center(
              child: Text("Tomorrow",
                style: TextStyle(
                  color: Colors.orange[900],
                  fontSize: 42,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView(
              addAutomaticKeepAlives: true,
              children: [
                for(var i = 0; i < data.length; i++)
                Container(
                  margin: EdgeInsets.all(8),
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                            backgroundColor: Colors.cyan[900],
                            label: Text((i+1).toString(),
                              style: TextStyle(
                                color: Colors.orange[200]
                              ),
                            )
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text(data[i]['agen'].toString(),
                                style: TextStyle(
                                  color: Colors.cyan[900]
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Colors.cyan[900],
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(data[i]['room_rate'],
                                    style: TextStyle(color: Colors.white,),
                                  ),
                                ),
                                Container(
                                  color: Colors.cyan[800],
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(data[i]["tgl_datang"].toString().split(" ")[0].toString(),
                                          style: TextStyle(
                                            color: Colors.orange[200]
                                          ),
                                        )
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(data[i]['tgl_berang'].toString().split(" ")[0].toString(),
                                          style: TextStyle(
                                            color: Colors.orange[200]
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(data[i]['lama']+' Night',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  color: Colors.cyan[900],
                                  child: Text(data[i]['gsegmen'],
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text("adult"),
                                          Chip(
                                            backgroundColor: Colors.cyan[900],
                                            label: Text(data[i]['pax'].toString(),
                                              style: TextStyle(
                                                color: Colors.orange[200]
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text("child"),
                                          Chip(
                                            backgroundColor: Colors.cyan[900],
                                            label: Text(data[i]['pax2'].toString(),
                                              style: TextStyle(
                                                color: Colors.orange[200]
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(data[i]['guestsegmen'])
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Text(data[i]['nama_tamu']),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.cyan[800],
                        padding: EdgeInsets.all(4),
                        child: Text(data[i]['jenis_kamar'],
                          style: TextStyle(
                            color: Colors.orange[200]
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text("Rp "+NumberFormat('#,###', 'in').format(int.parse(data[i]['hrg_room'])))
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text("TOTAL : Rp "+NumberFormat('#,##', 'in').format(int.parse(data[i]['total_harga'])))
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.centerRight,
                        child:InkWell(
                          onTap: () => Get.bottomSheet(DetailsReport(nores: data[i]['no_reservasi'],)),
                          child: Card(
                            color: Colors.cyan[900],
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text("details",
                                style: TextStyle(
                                  color: Colors.orange[100]
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}