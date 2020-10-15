import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/getx_app/routes/pages.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:gesco/ui/login_page.dart';
import 'package:gesco/ui/my_home_page.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Gesco());
}

class Gesco extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(context);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          User _user = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.clearPersistence();
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            getPages: Pages.routes,
            home: _user != null? ApplicationPage() : LoginPage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }

  Widget Loading() {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Container(
          child: CupertinoActivityIndicator(),
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget SomethingWentWrong(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Container(
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
                      //Navigator.pop(context);
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Text(
                'Erro ao carregar aplicação',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
