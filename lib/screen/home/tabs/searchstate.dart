import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_ui/src/model/userDB.dart';


  
   

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






// class Tabbar extends StatefulWidget {
//   Tabbar({this.screens});

//   static const Tag = "Tabbar";
//   final List<Widget> screens;
//   @override
//   State<StatefulWidget> createState() {
//   return _TabbarState();
//   }
// }

// class _TabbarState extends State<Tabbar> {
//   int _currentIndex = 0;
//   Widget currentScreen;

//   @override
//   Widget build(BuildContext context) {
//     var _l10n = PackedLocalizations.of(context);

//     return Scaffold(
//   body: IndexedStack(
//     index: _currentIndex,
//     children: widget.screens,
//   ),
//   bottomNavigationBar: BottomNavigationBar(
//     fixedColor: Colors.black,
//     type: BottomNavigationBarType.fixed,
//     onTap: onTabTapped,
//     currentIndex: _currentIndex,
//     items: [
//       BottomNavigationBarItem(
//         icon: new Icon(Icons.format_list_bulleted),
//         title: new Text(_l10n.tripsTitle),
//       ),
//       BottomNavigationBarItem(
//         icon: new Icon(Icons.settings),
//         title: new Text(_l10n.settingsTitle),
//       )
//     ],
//   ),
// );
//   }

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }