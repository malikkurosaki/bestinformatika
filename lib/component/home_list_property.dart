import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:probus_mobile/controllers/controller_home.dart';

class ListProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lsCom = ControllerHome.to.getListCompeny();
    return Container(
      color: Colors.teal[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var i = 0; i < lsCom.length; i++)
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.account_balance,
                        color: Colors.black,
                      )
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(lsCom[i]['name'].toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var x = 0; x < lsCom[i]['properties'].length; x++)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(lsCom[i]['properties'][x]['type'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                            ),
                          ),
                          Wrap(
                            children: [
                              for(var y = 0; y < lsCom[i]['properties'][x]['outlets'].length; y++)
                              Card(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () => ControllerHome.to.kePhisPage(lsCom[i]['properties'][x]['outlets'][y], lsCom[i]['properties'][x]['type']),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.blue[300],
                                          child: Icon(lsCom[i]['properties'][x]['type'] == "Hotel"?Icons.home:Icons.restaurant,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          child: Text(lsCom[i]['properties'][x]['outlets'][y]['name'])
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}