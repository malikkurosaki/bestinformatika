import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:probus_mobile/controllers/controller_home.dart';
import 'package:probus_mobile/controllers/controller_login.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        GetX(
          builder: (_) => RaisedButton(onPressed: ControllerLogin.to.sudahLogout.value? () => ControllerLogin.to.logout():null,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.orange,
            child: Text(ControllerLogin.to.sudahLogout.value?"LOGOUT":"loading ...",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: IconButton(icon: Icon(Icons.edit,
            color: Colors.cyan[900],
          ), onPressed: () => ControllerHome.to.keProfile(),),
        )
      ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}