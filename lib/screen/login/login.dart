import 'package:flutter/material.dart';
import 'dart:async';
import 'package:login_ui/src/model/userdata.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String message = ' ';
  var imageGif = 'assets/login_logo.gif';
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final loginData = [
    {
      'id': 0,
      'email': 'azeunkn0wn@gmail.com',
      'password': '12345678',
    },
    {
      'id': 1,
      'email': 'email1@gmail.com',
      'password': 'pass1',
    },
    {
      'id': 2,
      'email': 'email2@gmail.com',
      'password': 'pass2',
    },
    {
      'id': 3,
      'email': 'email3@gmail.com',
      'password': 'pass3',
    },
    {
      'id': 4,
      'email': 'email4@gmail.com',
      'password': 'pass4',
    },
  ];
  int userID;

  Map getUserData() {
    return UserData(userID).userData;
  }

  void _goLogin() {
    final String _email = emailFieldController.text.replaceAll(' ', '');
    final String _password = passwordFieldController.text.replaceAll(' ', '');

    for (var i = 0; i < loginData.length; i++) {
      if (loginData[i]['email'] == _email) {
        if (loginData[i]['password'] == _password) {
          userID = loginData[i]['id'];
          print('Success!');
          setState(() {
            imageGif = 'assets/success.gif';
            message = 'Success!';
          });
          
          Map userData = new UserData(userID).userData;
          Future.delayed(Duration(seconds: 3), () {Navigator.of(context).pushNamed('/dash', arguments: userData);},
          );
        } else {
          setState(() {
            imageGif = 'assets/wrong.gif';
            message = 'Wrong Password!';
          });
        }
        break;
      } else {
        setState(() {
          imageGif = 'assets/not_exist.gif';
          message = 'Does not exist!';
        });
      }
    }

    print(_email + ' ' + _password + ' ' + userID.toString());
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailFieldController,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );

    final passwordField = TextField(
      controller: passwordFieldController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _goLogin,
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 255.0,
                  child: Image.asset(
                    imageGif,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                Container(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                SizedBox(height: 10.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
