import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final userData = [
     {'id': 0, 'username': 'azeunkn0wn', 'location': 1, 'description': 'null', 'avatar': 'assets/aze.png'},
     {'id': 1, 'username': 'Mim'     , 'location': 2, 'description': 'null', 'avatar': 'assets/mim.png'},
     {'id': 2, 'username': 'Yam'     , 'location': 2, 'description': 'null', 'avatar': 'assets/yam.png'},
     {'id': 3, 'username': 'Heart'     , 'location': 3, 'description': 'null', 'avatar': 'assets/heartcat.png'},
     {'id': 4, 'username': 'Josetus'     , 'location': 3, 'description': 'null', 'avatar': 'assets/Josetus.png'},
   ];
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
              onPressed: () => Navigator.of(context).pushNamed('/login')
            ),
            Text(userID.toString())
          ],
        ),
      ),
    );
  }
}
