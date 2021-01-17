import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_forecast_occupancy.dart';

class PhisForecastOccupancy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX(
        initState: (state) => ControllerForecastOccupancy.to.init(),
        builder: (controller) => ControllerForecastOccupancy.to.loading.value?
        LoadingForecast():DetailForecast(forecast: ControllerForecastOccupancy.to.forecast,),
      ),
    );
  }
}

class LoadingForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.orange,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DetailForecast extends StatelessWidget {
  final List forecast;

  const DetailForecast({Key key, this.forecast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("Forecast Occupancy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: [
              for(var i = 0; i< forecast.length; i++)
              Card(
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        color: Colors.cyan,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: Text(ControllerForecastOccupancy.to.namaBulan[int.parse(forecast[i]['month'])-1].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        )
                      ),
                      Flexible(
                        child: Center(
                          child: Text(forecast[i]['occupancy'].toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.cyan
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Container(
      //       padding: EdgeInsets.all(8),
      //       child: Text("Forecast Occupancy",
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold
      //         ),
      //       )
      //     ),
      //     Card(
      //       color: Colors.cyan[600],
      //       child: Container(
      //         padding: EdgeInsets.all(8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("Month",
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
      //     for(var i = 0; i< forecast.length; i++)
      //     Card(
      //       margin: EdgeInsets.only(top: (i+2).toDouble(), right: ((i+2)*2).toDouble(), left: ((i+2)*2).toDouble()),
      //       color: Colors.cyan[i >= 9?900:(i+1)*100],
      //       child: Container(
      //         // padding: EdgeInsets.all(8),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Container(
      //               padding: EdgeInsets.all(8),
      //               child: Text(ControllerForecastOccupancy.to.namaBulan[int.parse(forecast[i]['month'])-1].toString(),
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 18
      //                 ),
      //               ),
      //             ),
      //             Card(
      //               child: Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Text(forecast[i]['occupancy'].toString(),
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 18
      //                   ),
      //                 ),
      //               ),
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