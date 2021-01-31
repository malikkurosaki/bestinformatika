import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/phis_ctrl.dart';

class Pilihbulan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      minChildSize: 1,
      initialChildSize: 1,
      builder: (context, scrollController) => 
      Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: BackButton()
              ),
              Container(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: ListWheelScrollView(
                        physics: ScrollPhysics(),
                        diameterRatio: 1,
                        itemExtent: 75,
                        onSelectedItemChanged: (value) => PlhBln.selectedItemChangeThn(value), 
                        children: List.generate(PlhBln.lsTahun.length, (i1) => 
                          Card(
                            color: Colors.blue,
                            child: Container(
                              child: Center(
                                child: Obx( () => 
                                  Text(PlhBln.lsTahun[i1].toString(),
                                    style: TextStyle(
                                      fontSize: i1 == PlhBln.idxThn.value?24: 12,
                                      color: i1 == PlhBln.idxThn.value?Colors.white: Colors.black
                                    ),
                                  )
                                )
                              )
                            ),
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      child: ListWheelScrollView(
                        physics: ScrollPhysics(),
                        diameterRatio: 1,
                        itemExtent: 75,
                        onSelectedItemChanged: (value) => PlhBln.selectedItemChangeBln(value), 
                        children: List.generate(PlhBln.lsbulan.length, (i1) => 
                          Card(
                            color: Colors.blue,
                            child: Container(
                              child: Center(
                                child: Obx( () => 
                                  Text(PlhBln.lsbulan[i1].toString(),
                                    style: TextStyle(
                                      fontSize: i1 == PlhBln.idxBln.value?24: 12,
                                      color: i1 == PlhBln.idxBln.value?Colors.white: Colors.black
                                    ),
                                  )
                                )
                              )
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
               Container(
                 margin: EdgeInsets.only(top: 16),
                 alignment: Alignment.bottomRight,
                 child: FlatButton(
                  color: Colors.blue,
                  onPressed: (){
                    Get.back();
                  }, 
                  child: Text("ok")
              ),
               )
            ],
          ),
        ),
      ),
    );
  }
}

class PlhBln extends PhisCtrl{
  static final idxThn = 0.obs;
  static final idxBln = 0.obs;
  static final lsTahun = List.generate(50, (index) => 2019 + index);
  static final lsbulan = List.generate(12, (index) => 1 + index);

  static selectedItemChangeThn(int value){
    idxThn.value = value;
  }

  static selectedItemChangeBln(int value){
    idxBln.value = value;
  }
}