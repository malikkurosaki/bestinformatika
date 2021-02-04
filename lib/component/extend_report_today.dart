import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:probus_mobile/component/detail_expanded_report.dart';
import 'package:probus_mobile/controllers/controller_extend_report.dart';
import 'package:get/get.dart';

class ExtendReportToday extends GetView<ControllerExtenReportOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.loading.value?
      LoadingReportToday(): DetailReportToday(data: ControllerExtenReportOverview.to.today,),
    );
  }
}

class LoadingReportToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DetailReportToday extends StatelessWidget {
  final RxList data;

  const DetailReportToday({Key key, this.data}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.cyan[900],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/today.png')
              )
            ),
            height: 100,
            child: Center(
              child: Text("Today",
                style: TextStyle(
                  color: Colors.orange[100],
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
                  color: Colors.grey[300],
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                            backgroundColor: Colors.cyan[900],
                            label: Text((i+1).toString(),
                              style: TextStyle(
                                color: Colors.orange[100]
                              ),
                            )
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text(data[i]['agen'],
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
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
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
                                      color: Colors.orange[100]
                                    ),
                                  )
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Chip(
                                            backgroundColor: Colors.cyan[900],
                                            label: Text(data[i]['pax'].toString(),
                                              style: TextStyle(
                                                color: Colors.orange[100]
                                              ),
                                            )
                                          ),
                                          Text("adult"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Chip(
                                            label: Text(data[i]['pax2'].toString(),
                                              style: TextStyle(
                                                color: Colors.orange[100]
                                              ),
                                            ),
                                            backgroundColor: Colors.cyan[900],
                                          ),
                                          Text("child"),
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
                        color: Colors.cyan[900],
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
                              child: Text("Rp "+NumberFormat('#,###', 'in').format(int.parse(data[i]['hrg_room'])),)
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text("TOTAL : Rp "+NumberFormat('#,###', 'in').format(int.parse(data[i]['total_harga'])))
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.centerRight,
                        child: InkWell(
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