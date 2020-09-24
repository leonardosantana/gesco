import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesco/ui/my_home_page.dart';

class LoginBloc {

  bool validatePasswordInput;

  String validatePassword(String password) {

    if (this.validatePasswordInput && password.isEmpty) {
      return 'Entre uma senha';
    }

    return null;
  }

  String validateLogin(String input) {

    if (input.isEmpty) {
      return 'Entre um email valido';
    }

    return null;
  }

  signIn( BuildContext context,  GlobalKey<FormState> form, String password, String login) async {

      try {

        /*FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: login, password: password)).user;
        print(user.email);*/

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(/*user: user*/)));

      }
      catch (e) {
        print(e.message);

      }

  }

  forgetPassword( BuildContext context,  GlobalKey<FormState> form, String login) async {

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: login);
    } catch (e) {
      print(e.message);
    }

  }

  bool formValidate(GlobalKey<FormState> formKey, bool validatePassword) {

    this.validatePasswordInput = validatePassword;

    if(formKey.currentState.validate()) {

      formKey.currentState.save();

      return true;
    }

    return false;


  }

}
