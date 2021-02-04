import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:probus_mobile/controllers/controller_top_10_room_production.dart';

class PhisTop10RoomProduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX(
        initState: (state) => ControllerTop10RoomProduction.to.init(),
        builder: (controller) => !ControllerTop10RoomProduction.to.loading.value?
        DetailTop10(toproom: ControllerTop10RoomProduction.to.top10room,): LoadingTop10Room(),
      )
    );
  }
}

class LoadingTop10Room extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.purple,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class DetailTop10 extends StatelessWidget {
  final List toproom;

  const DetailTop10({Key key, this.toproom}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Text("Top 10 Room Production",
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
              for(var i = 0; i < toproom.length; i++)
              Container(
                margin: EdgeInsets.all(4),
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Tooltip(
                      message: toproom[i]['nm_agen'].toString().toLowerCase(),
                      child: Container(
                        color: Colors.cyan[900],
                        padding: EdgeInsets.all(4),
                        width: double.infinity,
                        child: Text(toproom[i]['nm_agen'].toString().toLowerCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                    Flexible(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(toproom[i]['value'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
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
    );
  }
}
