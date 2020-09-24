import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gesco/app/build/new_build/new_build_page.dart';

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
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: NewBuildPage(),
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

  Widget SomethingWentWrong() {
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
}
