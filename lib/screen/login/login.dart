import 'package:flutter/material.dart';
import 'package:login_ui/src/model/userDB.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  String message = ' ';
  var imageGif = 'assets/login_logo.gif';
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  int myUserID;
  
  @override
  void initState() {
    _emailFieldController.addListener(() {
      setState(() {
        imageGif = 'assets/login_logo.gif';
        message = ' ';
        _passwordFieldController.text = null;
      });
    });
    super.initState();
  }

  void _doLogin() async {
    final String _email = _emailFieldController.text.replaceAll(' ', '').trim();
    final String _password = _passwordFieldController.text;

    final result = await DataBase().login(_email, _password);

    if (result[0] == 0) {
      myUserID = result[1];
      print('Success!');
      setState(() {
        imageGif = 'assets/success.gif';
        message = 'Success!';
        _passwordFieldController.text = null;
      });

      DataBase().getUserData(myUserID).then((myUserData) {
        Navigator.of(context).pushNamed('/home', arguments: myUserData);
      });
    } else {
      if (result[0] == 1) {
        setState(() {
          imageGif = 'assets/wrong.gif';
          message = 'Wrong credentials. Try again!';
          _passwordFieldController.text = null;
        });
      } else if (result[0] == 2) {
        setState(() {
          imageGif = 'assets/not_exist.gif';
          message = 'Cannot connect to database';
          _passwordFieldController.text = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: _emailFieldController,
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
      controller: _passwordFieldController,
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
        onPressed: _doLogin,
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
