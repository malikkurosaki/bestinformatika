import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../store.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/tema.dart';

typedef PilihTanggal<T> = Function(T);
class MasterDate extends StatelessWidget {
  final lihat = ValueNotifier(Store.date);
  final PilihTanggal pilihTanggal;
  MasterDate(this.pilihTanggal);

  @override
  Widget build(BuildContext context) => 
  TextButton(
    onPressed: ()async{
      final dt = await showDatePicker(
        context: Get.context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime(DateTime.now().year - 1, DateTime.now().month), 
        lastDate: DateTime(DateTime.now().year + 1)
      );
      if(dt != null) {
        final tang = dt.toString().split(" ")[0];
        lihat.value = tang;
        await Store.setDate(tang);
        pilihTanggal(tang);
      }
    }, 
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("date ").biasa,
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
