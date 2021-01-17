import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:probus_mobile/controllers/controller_extend_report.dart';

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black,
            Colors.red[300]
          ]
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.cyan,
                  Colors.orange[100]
                ]
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/tomorrow.jpg')
              )
            ),
            height: 100,
            child: Center(
              child: Text("Tomorrow",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView(
              addAutomaticKeepAlives: true,
              children: [
                for(var i = 0; i < data.length; i++)
                Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              color: Colors.cyan[800],
                              padding: EdgeInsets.all(8),
                              child: Text((i+1).toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.cyan[900],
                                child: Text(data[i]['agen'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
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
                            Card(
                              color: Colors.cyan[900],
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(data[i]['room_rate'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        color: Colors.cyan[700],
                                        padding: EdgeInsets.all(8),
                                        child: Text(data[i]["tgl_datang"].toString().split(" ")[0].toString())
                                      ),
                                      Container(
                                        color: Colors.cyan[800],
                                        padding: EdgeInsets.all(8),
                                        child: Text(data[i]['tgl_berang'].toString().split(" ")[0].toString())
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(data[i]['lama']+' Night',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
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
                                    padding: EdgeInsets.all(8),
                                    child: Text(data[i]['gsegmen'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Text("adult".toUpperCase()),
                                            CircleAvatar(
                                              backgroundColor: Colors.cyan,
                                              child: Text(data[i]['pax'].toString(),
                                                style: TextStyle(
                                                  color: Colors.white
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
                                            Text("child".toUpperCase()),
                                            CircleAvatar(
                                              backgroundColor: Colors.cyan,
                                              child: Text(data[i]['pax2'].toString(),
                                                style: TextStyle(
                                                  color: Colors.white
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
                                    padding: EdgeInsets.all(8),
                                    child: Text(data[i]['guestsegmen'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(data[i]['nama_tamu'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 24
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.cyan[100],
                          padding: EdgeInsets.all(8),
                          child: Text(data[i]['jenis_kamar'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan[700]
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.cyan[500],
                                padding: EdgeInsets.all(8),
                                child: Text("Rp "+NumberFormat('#,###', 'in').format(int.parse(data[i]['hrg_room'])),
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                )
                              ),
                            ),
                            Container(
                              color: Colors.cyan[400],
                              padding: EdgeInsets.all(8),
                              child: Text("TOTAL : Rp "+NumberFormat('#,##', 'in').format(int.parse(data[i]['total_harga'])),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              )
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            color: Colors.cyan[900],
                            onPressed: () {}, 
                            child: Text("detail",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                          ),
                        )
                      ],
                    ),
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