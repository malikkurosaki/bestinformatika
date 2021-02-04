import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_reservation_overview.dart';

class PhisReservationOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("Reservation Overview",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          GetX(
            initState: (state)  =>  ControllerReservationOverview.to.init(),
            builder: (controller) => !ControllerReservationOverview.to.loading.value?Container(
              child: ReservationOverView(reservation: ControllerReservationOverview.to.reservation,),
            ): Container(
              child: Column(
                children: [
                  for(var i = 0; i< 2; i++)
                  Container(
                    child: Row(
                      children: [
                        for(var x = 0; x < 4; x++)
                        Expanded(
                          child: Card(
                            color: Colors.orange[100],
                            child: Container(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationOverView extends StatelessWidget {
  final reservation;

  const ReservationOverView({Key key, this.reservation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              reservationItem("Booking", reservation['a']['Booking'].toString()),
              reservationItem("Confirmed", reservation['a']['Confirmed'].toString()),
              reservationItem("Canceled", reservation['a']['Canceled'].toString()),
              reservationItem("No Show", reservation['a']['No Show'].toString())
            ],
          ),
          Row(
            children: [
              reservationItem("House Used", reservation['b']['House Used'].toString()),
              reservationItem("Compliment", reservation['b']['Compliment'].toString()),
              reservationItem("Pay Room", reservation['b']['Pay Room'].toString()),
              reservationItem("Out Of Order", reservation['b']['Out Of Order'].toString())
            ],
          )
        ],
      ),
    );
  }

  Widget reservationItem(String name, String value){
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        color: Colors.cyan[900],
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: Text(name,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.grey[200],
              padding: EdgeInsets.all(8),
              child: Text(value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}