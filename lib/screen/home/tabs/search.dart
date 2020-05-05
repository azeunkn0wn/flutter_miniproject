import 'package:flutter/material.dart';
import 'package:login_ui/src/model/userDB.dart';

class LookUp extends StatelessWidget {
  final int myUserID;
  LookUp(this.myUserID);

  Future<List<People>> byCategory(myUserID,
      {location, category, username}) async {
    List<People> peopleList = List<People>();

    final results = await DataBase().search(
      myUserID,
      location: location,
      category: category,
      username: username,
    );
    for (var i in results) {
      peopleList.add(
        People(
            id: i[0],
            username: i[1],
            firstname: i[2],
            avatar: i[3],
            contact: i[4],
            location: i[5],
            description: i[6]),
      );
    }
    return peopleList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: byCategory(
          myUserID,
          location: '1',
          category: null,
          username: null,
        ),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = Wrap(
              direction: Axis.horizontal,
              runSpacing: 20,
              spacing: 20,
              children: snapshot.data,
            );
          } else {
            child = Container(
              width: 0,
              height: 0,
            );
          }
          return Container(
            child: SingleChildScrollView(
              child: Center(
                child: child,
              ),
            ),
          );
        });
  }
}

  // People Tiles Widget
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
            DataBase().getUserData(id).then((userData) {
              print(userData);
              Navigator.of(context).pushNamed('/profile', arguments: userData);
            });
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