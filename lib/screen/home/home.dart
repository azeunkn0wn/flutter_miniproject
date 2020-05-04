import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final int userID;
  Home({
    @required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("Log out"),
                onPressed: () => Navigator.of(context).pushNamed('/login')),
            Text(userID.toString())
          ],
        ),
      ),
    );
  }
}
