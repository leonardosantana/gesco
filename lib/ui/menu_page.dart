import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class MenuPage extends StatelessWidget {
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
            Row(
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
            ),
            boxSpaceVertical,
            Row(
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
            ),
            boxSpaceVertical,
            Row(
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
            ),
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
