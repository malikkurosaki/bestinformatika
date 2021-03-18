import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/store.dart';
import 'package:probus_mobile/tema.dart';

typedef HasilTipe<T> = Function(T);
class MasterTipe extends StatelessWidget{
  final List<String> lsTipe;
  final ValueNotifier lihat = ValueNotifier(Store.tipe);
  final HasilTipe hasil;
  MasterTipe({Key key,@required this.hasil, @required this.lsTipe}) : super(key: key);
  
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
                  controller:scrollController,
                  physics: BouncingScrollPhysics(),
                  children: [
                    for(final ls in lsTipe)
                    ListTile(
                      title: Text(ls),
                      onTap: () async{
                        lihat.value = ls;
                        hasil(ls);
                        await Store.setTipe(ls);
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
        Text("type ").biasa,
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