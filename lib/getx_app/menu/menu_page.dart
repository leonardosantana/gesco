import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/getx_app/menu/menu_controller.dart';
import 'package:gesco/getx_app/user/user_page.dart';
import 'package:get/get.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuPage extends StatelessWidget {
  MenuController controller = Get.put(MenuController());
  TextStyle textStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontSize: 20);

  SizedBox boxSpaceVertical = SizedBox(height: 20.0);
  SizedBox boxSpaceHorizontal = SizedBox(width: 10.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(() => controller.isAdmin.value
                ? Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                      ),
                      boxSpaceHorizontal,
                      Text(
                        'Produtos',
                        style: textStyle,
                      ),
                    ],
                  )
                : Container()),
            boxSpaceVertical,
            Obx(() => controller.isAdmin.value
                ? Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_balance,
                        color: Colors.white,
                      ),
                      boxSpaceHorizontal,
                      Text(
                        'Nova Obra',
                        style: textStyle,
                      ),
                    ],
                  )
                : Container()),
            boxSpaceVertical,
            Obx(() => controller.isAdmin.value
                ? Row(
                    children: <Widget>[
                      Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      boxSpaceHorizontal,
                      Text(
                        'Mestres de Obra',
                        style: textStyle,
                      ),
                    ],
                  )
                : Container()),
            boxSpaceVertical,
            Obx(() => controller.isAdmin.value
                ? InkWell(
                  onTap: () => Get.to(UserPage()),
                  child: Row(
              children: <Widget>[
                  Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  boxSpaceHorizontal,
                  Text(
                    'Usuários',
                    style: textStyle,
                  ),
              ],
            ),
                )
                : Container()),
            boxSpaceVertical,
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut().whenComplete(() {
                  new Future.delayed(const Duration(seconds: 5), () => exit(0));
                });
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  boxSpaceHorizontal,
                  Text(
                    'Sair',
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
