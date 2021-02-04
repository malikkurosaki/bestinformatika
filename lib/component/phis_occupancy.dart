import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_occupancy.dart';
import 'package:probus_mobile/controllers/controller_phis.dart';
import 'package:get/get.dart';

class PhisOccupancy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX(
        initState: (x)  =>  ControllerOccupancy.to.init(),
        builder: (_) => !ControllerOccupancy.to.loading.value? 
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/pantai.png')
                )
              ),
              child: Column(
                children: [
                  Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.centerRight,
                    child: Text(GetStorage().read('outlet')['name'],
                      style: TextStyle(
                        color: Colors.orange[700],
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Card(
                                shadowColor: Colors.white,
                                elevation: 10,
                                color: Colors.white54,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  alignment: Alignment.center,
                                  child: Text(ControllerOccupancy.to.occupancy['yesterday'].toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ),
                              ),
                              Card(
                                child: Text("%",
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                              )
                            ],
                          ),
                          Card(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text("Yesterday")
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white54,
                                radius: 70,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  alignment: Alignment.center,
                                  child: Text(ControllerOccupancy.to.occupancy['today'].toString(),
                                      style: TextStyle(
                                      fontSize: 73,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[700],
                                    ),
                                  )
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text("%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text("Today",
                                style: TextStyle(
                                  fontSize: 24
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Card(
                                elevation: 10,
                                shadowColor: Colors.white,
                                color: Colors.white54,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  alignment: Alignment.center,
                                  child: Text(ControllerOccupancy.to.occupancy['tomorrow'].toString(),
                                      style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ),
                              ),
                              Card(
                                child: Text("%",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Card(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text("Tomorrow")
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ControllerOccupancy.to.tunggu.value?CircularProgressIndicator(strokeWidth: 2,):SizedBox.shrink()
          ],
        ): Container(
        height: 200,
        color: Colors.cyan,
        child: Center(
          child: Row(
            children: [
              for(var i = 0; i< 3; i++)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}