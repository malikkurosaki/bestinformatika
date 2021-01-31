import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/log_ctrl.dart';

class MyLogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Obx( () => 
            ListView(
              children: List.generate(LogCtrl.lsLog.length, (index) => 
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(LogCtrl.lsLog[index]),
                )
              ),
            )
          ),
        ),
      ),
    );
  }
}