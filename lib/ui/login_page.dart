import 'package:gesco/blocs/login_bloc.dart';
import 'package:gesco/ui/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _password;
  String _login;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.2,
                    0.8,
                    0.9
                  ],
                  colors: [
                    Colors.red,
                    Colors.deepOrangeAccent,
                    Colors.deepOrange,
                    Colors.redAccent
                  ])),
          child: Center(
            child: loginData(),
          ),
        )
    );
  }

  Widget loginData() {
    return Container(
      height: 300.00,
      width: 300.00,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.deepOrangeAccent, //                   <--- border color
            width: 1.0,
          )
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            loginField(),
            passwordField(),
            buttonField(),
            forgetPasswordField()
          ],
        ),
      ),
    );
  }

  Widget forgetPasswordField(){
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          child: MaterialButton(
              highlightColor: Colors.transparent,
              //splashColor: Colors.deepOrangeAccent,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 4.0, horizontal: 4.0),
                child: Text(
                  "Esqueci minha senha",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                      fontFamily: "WorkSansBold"),
                ),
              ),
              onPressed: (){resetPassword();}
          ),
        ));
  }

  Widget buttonField(){
    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            gradient: new LinearGradient(
                colors: [
                  Colors.red,
                  Colors.deepOrangeAccent
                ],
                begin: const FractionalOffset(0.2, 0.2),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.deepOrangeAccent,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 42.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: "WorkSansBold"),
                ),
              ),
              onPressed: (){signIn();}
          ),
        ));
  }

  void signIn() {

    if(bloc.formValidate(_formKey, true)){
      bloc.signIn(context, _formKey, _password, _login, this._scaffoldKey);
    }

  }

  void resetPassword() {

    if(bloc.formValidate(_formKey, false)){

      bloc.forgetPassword(context, _formKey, _login);
      this._scaffoldKey.currentState.showSnackBar(SnackBar(content: new Text('Email de redefinição de senha enviado!')));

    }

  }

  Widget loginField() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: (input) => bloc.validateLogin(input),
        onSaved: (input) => _login = input,
        decoration: InputDecoration(
          labelText: 'Login',
        ),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        validator: (input) => bloc.validatePassword(input),
        onSaved: (input) => _password = input,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
    );
  }
}
