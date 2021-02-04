import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:probus_mobile/controllers/controller_daily_movelemt.dart';

class PhisDailymovement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("Daily Movement",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          GetX(
            initState: (state)  =>  ControllerDailyMovement.to.init(),
            builder: (controller) => !ControllerDailyMovement.to.loading.value?Container(
              child: Container(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    detailDailyMovement("Room Salles",ControllerDailyMovement.to.movement['roomSales']),
                    detailDailyMovement("Room Unsold",ControllerDailyMovement.to.movement['roomUnSold']),
                    detailDailyMovement("Revenue",ControllerDailyMovement.to.movement['revenue']),
                    detailDailyMovement("Room Rate",ControllerDailyMovement.to.movement['roomRate']),
                    detailDailyMovement("Lenght Of Stay",ControllerDailyMovement.to.movement['lenghtOfStay']),
                    detailDailyMovement2("Guest", guest(ControllerDailyMovement.to.movement['guest'])),
                    detailDailyMovement2("Reservation", reservation(ControllerDailyMovement.to.movement['reservationSummary'])),
                    detailDailyMovement2("Inhouse", inHouse(ControllerDailyMovement.to.movement['inHouseSummary'])),
                  ],
                ),
              ),
            ): Container(
              child: Center(
                child: Wrap(
                  children: [
                    for(var i = 0; i < 6; i++)
                    Card(
                      color: Colors.teal[100],
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget detailDailyMovement(String judul, Map data){
    return Container(
      color: Colors.grey[200],
      margin: EdgeInsets.all(4),
      width: Get.width/2.1,
      height: 150,
      child: Column(
        children: [
          Container(            
            color: Colors.cyan[900],
            width: double.infinity,
            padding: EdgeInsets.all(4),
            child: Text(judul,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),
            ),
          ),
          Flexible(
            child: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          width: double.infinity,
                          child: Text("Today"),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(NumberFormat('#,###','in').format(data['today']),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Center(
                    child: Container(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              child: Text("Yesterday"),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(NumberFormat('#,###','in').format(data['yesterday']),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
          
        ],
      ),
    );
  }


  /// induk yang bawah 
  /// guest , reservation , inhouse
  Widget detailDailyMovement2(String judul, List<Widget> widget ){
    return Container(
      color: Colors.grey[200],
      margin: EdgeInsets.all(4),
      width: Get.width/2.1,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget,
            )
          ),
          Container(
            color: Colors.cyan[900],
            width: double.infinity,
            padding: EdgeInsets.all(4),
            child: Text(judul,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> guest(Map data){
    return [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: Text("Today",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Flexible(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("Adult"),
                            Flexible(
                              child: Center(
                                child: Text(data['todayAdult'].toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              )
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Child"),
                            Flexible(
                              child: Center(
                                child: Text(data['todayChild'].toString(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                width: double.infinity,
                child: Text("Yesterday",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Adult"),
                          Flexible(
                            child: Center(
                              child: Text(data['yesterdayAdult'].toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Child"),
                          Flexible(
                            child: Center(
                              child: Text(data['yesterdayChild'].toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ];
  }

  List<Widget> reservation(Map data){
    return [
      Flexible(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("Booking")
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['Booking'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("Confirmed")
                  ),
                  Flexible(
                    child: Center(
                      child: Container(
                        child: Text(data['Confirmed'].toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    )
                  ),
                ],
              )
            )
          ],
        )
      ),
      Flexible(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("Canceled")
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['Canceled'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("No Show")
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['No Show'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ),
                ],
              )
            )
          ],
        )
      )
    ];
  }

  List<Widget> inHouse(Map data){
    return [
      Flexible(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("House Used",)
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['House Used'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("Compliment")
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['Compliment'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ),
                ],
              )
            )
          ],
        )
      ),
      Flexible(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("Pay Room")
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['Pay Room'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text("Out Order")
                  ),
                  Flexible(
                    child: Center(
                      child: Text(data['Out Of Order'].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ),
                ],
              )
            )
          ],
        )
      )
    ];
  }

}