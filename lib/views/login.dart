import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hide_keyboard/hide_keyboard.dart';
import 'package:probus_mobile/rest_api.dart';

import '../tema.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> kunciForm = GlobalKey<FormState>();
    return HideKeyboard(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text("login",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w100
                        ),
                      )
                    ),
                    FutureBuilder(
                      future: LoginCtrl.init(),
                      builder: (context, snapshot) => snapshot.connectionState != ConnectionState.done?
                      Text("loading ..."):
                      Form(
                        key: kunciForm,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for(ModelLogin lg in LoginCtrl.lsLogin)
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: TextFormField(
                                validator: (value) => value.isEmpty? 
                                "no empty field please": 
                                lg.name == "email" && !value.isEmail? 
                                "wrong email format": null,

                                onChanged: (value) => lg.data = value,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  icon: Icon(lg.icon),
                                  labelText: lg.name,
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: InputBorder.none,
                                  hintText: lg.hint
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Card(
                        color: Colors.blue[900],
                        child: InkWell(
                          onTap: () {
                            if(kunciForm.currentState.validate()){
                              LoginCtrl.cobaLogin();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            padding: EdgeInsets.all(8),
                            child: Text("login",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w100,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginCtrl extends MyCtrl{
  static final lsLogin = <ModelLogin>[].obs;

  static init()async{
    lsLogin.assignAll(ModelLogin.getDataLogin());
  }

  static cobaLogin()async{
    final paket = {
      "email": lsLogin[0].hint,
      "password": lsLogin[1].hint
    };
    await RestApi().login(paket);
  }
}


class ModelLogin{
  String name;
  IconData icon;
  String data;
  String hint;

  ModelLogin({this.name, this.icon, this.data, this.hint});

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    name: json['name'],
    icon: json['icon'],
    data: json['data'],
    hint: json['hint']
  );

  static final _listLogin = [
    {
      "name": "email",
      "icon": Icons.email,
      "data": "",
      "hint": "administrator@app.com"
    },
    {
      "name": "password",
      "icon": Icons.vpn_key,
      "data": "",
      "hint": "123456"
    }
  ];

   static List<ModelLogin> getDataLogin() => _listLogin.map((e) => ModelLogin.fromJson(e)).toList();
}