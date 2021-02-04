import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:probus_mobile/component/logout.dart';
import 'package:probus_mobile/controllers/controller_profile.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.cyan[900],
      child: Row(
        children: [
        Card(
          elevation: 7,
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              maxRadius: 40,
              child: Icon(Icons.account_circle_outlined,
                size: 80,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(children: [
              Text(ControllerProfile.to.getUserName(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              LogoutButton(),
            ],
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        )
      ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}