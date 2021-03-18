import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';
import 'package:get/get.dart';
import 'master_tipe.dart';



class MasterDept extends StatelessWidget {
  final List<String> lsTipe = ["ALL"];
  final ValueNotifier lihat = ValueNotifier(Store.dept);
  final HasilTipe hasil;
  MasterDept(this.hasil);
  
  @override
  Widget build(BuildContext context) => 
  TextButton(
    onPressed: () => Get.bottomSheet(
      DraggableScrollableSheet(
        builder: (context, scrollController) => 
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              Flexible(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    for(final ls in lsTipe)
                    ListTile(
                      title: Text(ls),
                      onTap: () async{
                        lihat.value = ls;
                        hasil(ls);
                        await Store.setDept(ls);
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ), 
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("dept ").biasa,
        ValueListenableBuilder(
          valueListenable: lihat,
          builder: (context, value, child) => 
          Text(value).boldUpper,
        ),
        Icon(Icons.arrow_drop_down)
      ],
    )
  );
}