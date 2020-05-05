import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  final myUserData;
  ProfileBody(this.myUserData);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 25.0),
            Container(
              // child: FadeInImage.assetNetwork(placeholder: myUserData['avatar'], image: myUserData['avatar']                  ),
              width: 250,
              height: 250,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: new DecorationImage(
                  image: NetworkImage(myUserData['avatar']),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Column(children: <Widget>[
                Text(myUserData['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 33,
                    )),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(myUserData['location_name']),
                  ],
                ),
                SizedBox(height: 35),
                Text(myUserData['description'], style: TextStyle(fontSize: 15)),
              ], crossAxisAlignment: CrossAxisAlignment.start),
            ),
          ],
        ),
      ),
    );
  }
}
