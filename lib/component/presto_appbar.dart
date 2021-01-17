import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';

class PrestoAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/restaurant.jpg',)
        )
      ),
      height: 200,
      child: ButtonpilihOutlet()
    );
  }
}

class ButtonpilihOutlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundColor: Colors.black45,
              child: BackButton(),
            )
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(PrestoCtrl.to.property_name.value.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Card(
            color: Colors.brown,
            child: InkWell(
              onTap: () => Get.bottomSheet(PilihOutlet()),
              child: Container(
                padding: EdgeInsets.all(8),
                child: GetX(
                  initState: (state) => PrestoBarController.mendapatkanMasterOutlet(),
                  builder: (controller) => !PrestoBarController.tunggu.value?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(PrestoCtrl.to.kode_out_text.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ): Center(
                    child: CircularProgressIndicator(),
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PilihOutlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DraggableScrollableSheet(
        builder: (context, scrollController) => Card(
          child: ListView(
            controller: scrollController,
            children: [
              Text("Choose Outlet",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              for(var i = 0; i < PrestoBarController.lsOutlet.length; i++)
              ListTile(
                leading: Icon(Icons.account_tree),
                title: Text(PrestoBarController.lsOutlet[i]['nama_out']),
                onTap: () => PrestoBarController.outletPilihan(i),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PrestoBarController extends PrestoCtrl{

  //static final namaoutlet = "choose outlet".obs;
  static final lsOutlet = [].obs;
  static final tunggu = false.obs;

  static mendapatkanMasterOutlet() async {
    tunggu.value = true;
    if(GetStorage().hasData("master_outlet")){
      lsOutlet.assignAll(GetStorage().read("master_outlet"));
      tunggu.value = false;
    }
    try {
      Response res = await ControllerApi.to.masterOutlet();
      final data = res.body['data']['data']??[];
      lsOutlet.assignAll(data);
      await GetStorage().write("master_outlet", data);
    } catch (e) {
      print(e);
    }
    tunggu.value = false;
  }

  static outletPilihan(int i)async{
    PrestoCtrl.to.kode_out_text.value = lsOutlet[i]['nama_out'];
    PrestoCtrl.to.kode_out.value = lsOutlet[i]['kode_out'].toString();

    Get.back();
    PrestoBarController().updateData();
  }
}