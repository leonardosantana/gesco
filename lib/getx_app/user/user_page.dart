import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/getx_app/home/application_page.dart';
import 'package:gesco/getx_app/user/user_controller.dart';
import 'package:gesco/getx_app/user/user_model.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/common_styles.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  double screenWidth;
  double screenHeight;

  UserController controller;

  UserPage() {
    controller = Get.put(UserController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 8,
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.to(ApplicationPage());
                        },
                        child: AppHeader(isMainPage: false),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(5),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          newUserButton(),
                          SizedBox(height: 20,),
                          Text(
                            'Usuários:',
                            style: CommonStyles.SectionTextStyle(),
                          ),
                          SizedBox(height: 10,),
                          buildDetailsUser(),
                        ]),
                  ),
                ],
              ),
            )),
      ),
    );

  }

  Widget buildDetailsUser() {
    return Obx(() => ListView.builder(
      itemCount: controller.users.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildUserTile(controller.users[index])],
        );
      },
    ));

  }

  Widget newUserButton(){
    return FlatButton(
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.all(10.0),
      splashColor: Colors.blueAccent,
      onPressed: () => controller.addUser(),
      child: Text(
        'Adicionar usuário',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }


  buildUserTile(UserModel user) {
    return Card(
      elevation: 5.0,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(user.login),
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: user.isAdmin ? Colors.yellowAccent : Colors.blue ,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text( user.isAdmin ?'Admin': 'Usuario')),
              ],
            ),

          ],
        ),
      ),
    );
  }



}
