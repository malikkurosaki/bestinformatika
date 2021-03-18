import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/store.dart';

extension Tulisan on Text{

  get biasa => 
  Text(this.data,
    style: TextStyle(
      fontWeight: FontWeight.w300
    ),
  );

  get boldUpper =>
  Text(this.data.toUpperCase(),
    style: TextStyle(
      fontWeight: FontWeight.bold
    ),
  );

  get judul =>
  Text(this.data.toUpperCase(),
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300
    ),
    overflow: TextOverflow.clip,
  );

  get judulPutih =>
  Text(this.data.toUpperCase(),
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: Colors.white
    ),
    overflow: TextOverflow.clip,
  );

  get bold =>
  Text(this.data,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontWeight: FontWeight.bold
    ),
  );

  get boldPutih =>
  Text(this.data,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
  );

  get boldEnd => 
  Text(this.data,
    textAlign: TextAlign.end,
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  );

  get judulBold => 
  Text(this.data.toUpperCase(),
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold
    ),
  );

  get judulBoldPutih => 
  Text(this.data.toUpperCase(),
    style: TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.bold
    ),
  );

}

class MyCtrl extends GetxController{}

typedef OnFinis = Widget Function();
abstract class Bantuan extends StatelessWidget{

  final RxBool loading = false.obs;
  Future get restApi;
  String get title;

  final kosong = false.obs;
  final loading2 = false.obs;
  final RxBool invalidData = false.obs;
  final debugData = "".obs;
  static final RxBool debugMode = false.obs;

  void datanya(dynamic theData);
  
  Widget buat({
    @required OnFinis onFinis,
    @required bool denganJudul
  }) =>
  GetX(
    initState: (_) => init(),
    builder: (controller) => 
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        loading.value ?
        Container(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(strokeWidth: 0.5,)
        ): 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                denganJudul??true?
                judulContainer():
                SizedBox.shrink(),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: onFinis()
                ),
                Align(
                  alignment: Alignment.center,
                  child: loading2.value? 
                  CircularProgressIndicator(strokeWidth: 0.5,)
                  :SizedBox.shrink()
                )
              ],
            ),
          ],
        ),
        debugMode.value?
        Card(
          color: Colors.orange[100],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("DEBUG").judul,
                    Text(title??""),
                  ],
                )
                
              ),
              Container(
                height: 0.5,
                color: Colors.black54,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(GetStorage().read("debug_$kunci").toString())
              ),
            ],
          )
        ):
        SizedBox.shrink()
      ],
    ),
  );

  Widget judulContainer({String info}) => 
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title == null?
      SizedBox.shrink():
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(title).judul,
      ),
      info == null? SizedBox.shrink():
      Text(info??"").biasa
    ],
  );

   init()async{
    if(GetStorage().hasData(kunci)){
      datanya(await GetStorage().read(kunci));
      loading2.value = true;
    }else{
      loading.value = true;
      loading2.value = false;
    }
    
    await getData();
    loading.value = false;
    loading2.value = false;
  }

  getData()async{
    invalidData.value = false;
    final Response data = await restApi;
    // debugData.value = data.body.toString();
    if(debugMode.value) await GetStorage().write("debug_$kunci", data.body.toString());

    if(data.body is Map && data.body != null){
      final dt = data.body['data']['data'];
      if(dt.length != 0){
        datanya(dt);
        GetStorage().write(kunci, dt);
      }else{
        invalidData.value = true;
        datanya(null);
      }
      
    }else{
      invalidData.value = true;
      datanya(null);
    }
  }

  String get kunci => "$title ${GetStorage().read("hero_name")}".replaceAll(" ", "_");

  bool isMap(dynamic data) => (data != null && data is Map);
  bool isList(dynamic data) => (data != null && data is List);

}

class BantuanWidget{
 static BantuanWidget get ambil => BantuanWidget();
 BantuanWidget();

  Widget empatPilar(List lsData) => 
  Column(
    children: [
      for(final inh in lsData)
      Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 210,
        width: Get.width/1.1,
        child: FlipCard(
          direction: FlipDirection.VERTICAL,
          front: Card(
            color: Colors.blueGrey[700],
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(inh?.guestsegmen?.toString()??"",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.only(bottom: 8),
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        color: Colors.blueGrey[900],
                        child: Container(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: [
                              Text(inh?.roomRate?.toString()??"",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text(inh?.tglBerang?.toString()?.split(" ")[0]??"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                      ),
                                    )
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text(inh?.tglDatang?.toString()?.split(" ")[0]??"",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300
                                      ),
                                    )
                                  )
                                ],
                              ),
                              Text("${inh?.lama?.toString()??""} Night",
                                style: TextStyle(
                                  color: Colors.blueGrey
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(inh?.gsegmen?.toString()??"",
                              style: TextStyle(
                                color: Colors.white54,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      Text("Child",
                                        style: TextStyle(
                                          color: Colors.white60
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.blueGrey[900],
                                        child: Text(inh?.pax2?.toString()??"",)
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: [
                                      Text("Adult",
                                        style: TextStyle(
                                          color: Colors.white60
                                          ),
                                        ),
                                      CircleAvatar(
                                        backgroundColor: Colors.blueGrey[900],
                                        child: Text(inh?.pax?.toString()??"")
                                      )
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
                  Text(inh?.namaTamu??"",
                    style: TextStyle(
                      color: Colors.orange[100],
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(inh?.jenisKamar??"",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white54
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.meeting_room,
                            color: Colors.white54,
                          ),
                          Text(inh?.room?.toString()??"",
                            style: TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.grey[400],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(inh?.hrgRoom?.toString()??"").bold,
                        Text(inh.totalHarga?.toString()??"").bold,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ), 
          back: Card(
            color: Colors.blue[900],
            child: Container(
              child: Center(
                child: Text("halo"),
              ),
            ),
          ),
        ),
      )
    ],
  );

  Widget empatPilarButton({
    @required List lsData,
    @required String title,
    @required bool invalidData,
    Color warnaText,
    Color warnaIcon,
    @required String gambar
  }) => 
    Container(
    decoration: BoxDecoration(
      // border: Border.all(color: Colors.black, width: 0.3)
    ),
    margin: EdgeInsets.all(2),
    child: InkWell(
      onTap: () {
        Suara.soundPool.play(Suara.waterId);
        Get.dialog(BantuanWidget.ambil.kemunculan(lsData),
          barrierDismissible: true,
          barrierColor: Colors.black87
        );
      },
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          children: [
            Flexible(
              child: Image.asset(gambar,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ),
            Container(
              width: double.infinity,
              child: Stack(
                children: [
                  Card(
                    color: Colors.white,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2),
                      child: Text(title??"",
                        style: TextStyle(fontSize: 12,),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      child: Container(
                        alignment: Alignment.center,
                        height: 24,
                        width: 24,
                        child: Text(invalidData?"0": lsData.length.toString(),)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
    );


  Widget kemunculan(List lsData) => 
  DraggableScrollableSheet(
    initialChildSize: 0.6,
    maxChildSize: 1,
    builder: (context, scrollController) => 
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      controller: scrollController,
      child: BantuanWidget().empatPilar(lsData),
    ),
  );
}


