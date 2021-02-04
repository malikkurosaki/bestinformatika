import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:probus_mobile/controllers/controller_by_city.dart';

class PhisByCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX(
        initState: (state) => ControllerByCity.to.init(),
        builder: (controller) => ControllerByCity.to.loading.value?
        LoadingByCity():DetailByCity(byCity: ControllerByCity.to.byCity,),
      ),
    );
  }
}

class LoadingByCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.lightBlue,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DetailByCity extends StatelessWidget {
  final List byCity;

  const DetailByCity({Key key, this.byCity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("Top 10 Room By City",
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
              for(var i = 0; i< byCity.length; i++)
              Container(
                color: Colors.grey[200],
                margin: EdgeInsets.all(4),
                child: Column(
                  children: [
                    Container(
                      color: Colors.cyan[900],
                      width: double.infinity,
                      padding: EdgeInsets.all(4),
                      child: Text(byCity[i]['city'],
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                    Flexible(
                      child: Center(
                        child: Container(
                          child: Text(byCity[i]['value'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          )
                        ),
                      )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       padding: EdgeInsets.all(8),
      //       child: Text("Top 10 Room By City",
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold
      //         ),
      //       )
      //     ),
      //     Card(
      //       color: Colors.blueAccent,
      //       child: Container(
      //         padding: EdgeInsets.all(8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("City",
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
      //     for(var i = 0; i< byCity.length; i++)
      //     Card(
      //       color: Colors.blue[i >= 10?900:(i+1)*100],
      //       child: Container(
      //         // padding: EdgeInsets.all(8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(8),
      //               child: Text(byCity[i]['city'],
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 18
      //                 ),
      //               )
      //             ),
      //             Card(
      //               child: Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Text(byCity[i]['value'].toString(),
      //                   style: TextStyle(
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