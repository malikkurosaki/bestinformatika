import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/controllers/controller_api.dart';
import 'package:probus_mobile/controllers/presto_ctrl.dart';
import 'package:get/get.dart';


class PrestoProductSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Text("product".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blueGrey
                ),
              ),
            ),
            ButtonPilihGroup(),
            TampilanProdukSales()
          ],
        ),
      ),
    );
  }
}

class TampilanProdukSales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX(
        initState: (_) => ProductSalesCtrl.mendapatkanProductSales(PrestoCtrl.to.kode_out.value, PrestoCtrl.to.group.value),
        builder: (controller) => ProductSalesCtrl.productLoading.value?Center(child: CircularProgressIndicator(),):
        ProductSalesCtrl.lsProduct.isEmpty?Center(child: Text("No Data Available"),):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("qty".toUpperCase(),),
                  Text("total".toUpperCase()),
                  Text("price".toUpperCase()),
                ],
              ),
            ),
            for(var i = 0; i < ProductSalesCtrl.lsProduct.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ProductSalesCtrl.lsProduct[i]['name'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24),
                  child: Card(
                    color: Colors.blueGrey[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(ProductSalesCtrl.lsProduct[i]['qty'].toString(),),
                        Text(ProductSalesCtrl.lsProduct[i]['total'].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey
                          ),
                        ),
                        Text(ProductSalesCtrl.lsProduct[i]['price'].toString())
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ButtonPilihGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => Get.bottomSheet(PilihanGroup()),
        child: Card(
          color: Colors.blueGrey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(ProductSalesCtrl.textGroup.value.toString().toUpperCase(),
                  style: TextStyle(
                    color: Colors.blueGrey[100],
                    fontWeight: FontWeight.bold
                  ),
                ),
                Icon(Icons.arrow_drop_down,
                  color: Colors.blueGrey[100],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}


class PilihanGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DraggableScrollableSheet(
        builder: (context, scrollController) => Card(
          child: GetX(
            initState: (state) => ProductSalesCtrl.ambilListGroup(),
            builder: (controller) => ProductSalesCtrl.loadinglsGroup.value?Center(child: CircularProgressIndicator(),) : ListView(
              controller: scrollController,
              children: [
                for(var i = 0; i< ProductSalesCtrl.lsGroup.length; i++)
                ListTile(
                  title: Text(ProductSalesCtrl.lsGroup[i]),
                  onTap: () => ProductSalesCtrl.ambilNamaGroup(i),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}

class ProductSalesCtrl extends PrestoCtrl{
  static final productLoading = false.obs;
  static final lsProduct = [].obs;
  static final lsGroup = [].obs;
  static final textGroup = "food".obs;
  static final loadinglsGroup = false.obs;

  static mendapatkanProductSales(String kode_out, String group)async{
    productLoading.value = true;
    try {
      if(GetStorage().hasData("sales")){
        lsProduct.assignAll(GetStorage().read("sales"));
        productLoading.value = false;
      }

      Response res = await ControllerApi.to.prestoProductSales(PrestoCtrl.to.kode_out.value, PrestoCtrl.to.group.value);
      final List data = res.body['data']['data']??[];
      lsProduct.assignAll(data);
      await GetStorage().write("sales", data);

    } catch (e) {
      print(e);
    }
    productLoading.value = false;

  }

  static ambilListGroup()async{
    loadinglsGroup.value = true;

    if(GetStorage().hasData('ls_group')){
      lsGroup.assignAll(GetStorage().read('ls_group'));
      loadinglsGroup.value = false;
    }

    try {
      Response grp = await ControllerApi.to.masterGroupProduct();
      lsGroup.assignAll(grp.body['data']['data']);
      GetStorage().write("ls_group", grp.body['data']['data']);

    } catch (e) {
      print(e.toString());
    }
    loadinglsGroup.value = false;
  }

  static ambilNamaGroup(int i){
    // print({
    //   "group": PrestoCtrl.to.group.value,
    //   "aoutlet": PrestoCtrl.to.kode_out.value
    // });

    textGroup.value = lsGroup[i];
    ProductSalesCtrl.mendapatkanProductSales(PrestoCtrl.to.kode_out.value, PrestoCtrl.to.group.value);
    Get.back();
  }

  static final Map fake = {
    "response": 200,
    "message": "Product Sales",
    "status": true,
    "param": {
      "outlet": "1"
    },
    "data": {
      "data": [
        {
          "name": "CHEESE CROQUETTE DEAL",
          "qty": "6",
          "total": "65400",
          "price": "10900"
        },
        {
          "name": "FRENCH FRIES DEAL",
          "qty": "5",
          "total": "54500",
          "price": "10900"
        },
        {
          "name": "CHICKEN CROQUETTE DEAL",
          "qty": "2",
          "total": "21800",
          "price": "10900"
        },
        {
          "name": "CHEESE CAKE STRAWBERRY",
          "qty": "2",
          "total": "31600",
          "price": "15800"
        },
        {
          "name": "CARAMEL PUDDING",
          "qty": "1",
          "total": "15800",
          "price": "15800"
        }
      ]
    }
  };

}