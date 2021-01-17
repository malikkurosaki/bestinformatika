import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackButton(
                onPressed: () => Get.back(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}