import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final Map userData;
  MyProfile({this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 25.0),
              Container(
                width: 250,
                height: 250,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  image: new DecorationImage(
                    image: NetworkImage(userData['avatar']),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Column(children: <Widget>[
                  Text(userData['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      )),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Text(userData['location_name']),
                    ],
                  ),
                  SizedBox(height: 35),
                  Text(userData['description'], style: TextStyle(fontSize: 15)),
                  SizedBox(
                    height: 100,
                  ),
                ], crossAxisAlignment: CrossAxisAlignment.start),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
