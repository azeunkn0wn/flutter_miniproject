// People Tiles Widget
import 'package:flutter/material.dart';
import 'package:login_ui/src/getdata.dart';
class People extends StatelessWidget {
  final int id;
  final String username;
  final String firstname;
  final String avatar;
  final String contact;
  final String location;
  final String description;

  People({
    this.id,
    this.username,
    this.firstname,
    this.avatar,
    this.contact,
    this.location,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      margin: EdgeInsets.all(5),
      height: 200,
      width: 150,
      child: Material(
        child: InkWell( 
          onTap: () {
            
               profileData(id).then((userData) {Navigator.of(context).pushNamed('/profile',
                    arguments: userData);});           
          },
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 100,
                height: 100,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(avatar),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                username,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(location),
            ],
          ),
        ),
      ),
    );
  }
}