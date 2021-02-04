import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:probus_mobile/controllers/controller_by_country.dart';
import 'package:get/get.dart';

class PhisByCountry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX(
        initState: (state) => ControllerByCountry.to.init(),
        builder: (controller) => ControllerByCountry.to.loading.value?
        LoadingByCountry():DetailByCountry(byCountry: ControllerByCountry.to.byCountry,),
      ),
    );
  }
}

class LoadingByCountry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.green[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


class DetailByCountry extends StatelessWidget {
  final List byCountry;
  const DetailByCountry({Key key, this.byCountry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("Top 10 Room By Country",
              style: TextStyle(
                fontSize: 24,

              ),
            )
          ),
          GridView.count(
            crossAxisCount: 4,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              for(var i = 0 ; i < byCountry.length; i++)
              Container(
                margin: EdgeInsets.all(4),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: byCountry[i]['country'],
                      child: Container(
                        color: Colors.cyan[900],
                        width: double.infinity,
                        padding: EdgeInsets.all(4),
                        child: Text(byCountry[i]['country'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(byCountry[i]['value'].toString(),
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 42,
                            ),
                          )
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       padding: EdgeInsets.all(8),
      //       child: Text("Top 10 Room By Country",
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold
      //         ),
      //       )
      //     ),
      //     Card(
      //       color: Colors.teal,
      //       child: Container(
      //         padding: EdgeInsets.all(8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("Country",
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,fontSize: 24
      //               ),
      //             ),
      //             Text("Value",
      //                style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,fontSize: 24
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     for(var i = 0 ; i < byCountry.length; i++)
      //     Card(
      //       color: Colors.teal[i >= 10?900:(i+1)*100],
      //       child: Container(
      //         // padding: EdgeInsets.all(8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(8),
      //               child: Text(byCountry[i]['country'],
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 18
      //                 ),
      //               )
      //             ),
      //             Card(
      //               child: Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Text(byCountry[i]['value'].toString(),
      //                     style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 18
      //                   ),
      //                 )
      //               )
      //             )
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}