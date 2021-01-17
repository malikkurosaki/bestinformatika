
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:probus_mobile/console_log.dart';
import 'package:probus_mobile/controllers/controller_login.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return Container(
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0,4),
                          blurRadius: 8,
                          color: Colors.grey
                        )
                      ]
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Card(
                            shadowColor: Colors.blue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            child: TextField(
                              controller: ControllerLogin.to.email.value,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "email",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.email, 
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none
                                )
                              ),
                            ),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Card(
                            shadowColor: Colors.blue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            child: TextField(
                              controller: ControllerLogin.to.password.value,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "password",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.vpn_key, 
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none
                                )
                              ),
                            ),
                          )
                        ),
                        Container(
                          child: Card(
                            shadowColor: Colors.blue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                            child: Obx( () => ControllerLogin.to.sudah.value?InkWell(
                              radius: 60,
                              child: CircleAvatar(
                                maxRadius: 60,
                                backgroundColor: Colors.grey[200],
                                child: Text("OK",
                                  style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0,4),
                                        blurRadius: 4,
                                        color: Colors.grey
                                      )
                                    ],
                                    fontSize: 52,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                ),
                              ),
                              onTap: () => ControllerLogin.to.cobaLogin(),
                            ): CircularProgressIndicator()),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}