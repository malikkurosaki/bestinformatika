import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:probus_mobile/component/home_app_bar.dart';
import 'package:probus_mobile/component/home_list_property.dart';
import 'package:probus_mobile/controllers/controller_home.dart';
import 'package:probus_mobile/controllers/controller_login.dart';
import 'package:get/get.dart';
import 'package:probus_mobile/controllers/controller_profile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
            HomeAppBar(),
            Flexible(
              child: ListView(
                children: [
                  ListProperty()
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}

// Widget listProperty(){
//   return Container(
//     child: Card(
//       elevation: 5,
//       shadowColor: Colors.cyan,
//       color: Colors.cyan[700],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       child: InkWell(
//         onTap: (){},
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(1.0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 maxRadius: 30,
//                 child: Icon(Icons.hotel,
//                   size: 30,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(8),
//               child: Text("ini adalah nama hotel",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white
//                 ),
//               )
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }