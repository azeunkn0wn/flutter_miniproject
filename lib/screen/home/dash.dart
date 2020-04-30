import 'package:flutter/material.dart';
import 'package:login_ui/scr/model/userdata.dart';

class MyDashBoard extends StatefulWidget {
  final Map userData;

  MyDashBoard({@required this.userData, Object data});

  @override
  _MyDashBoardState createState() => _MyDashBoardState(userData);
}

class _MyDashBoardState extends State<MyDashBoard> {
  final Map userData;

  _MyDashBoardState(this.userData);

  // String get getIcon {
  //   return myIcon;
  // }
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: 1',
      style: optionStyle,
    ),
    Text(
      'Index 2: xx',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _widgetOptions.elementAt(_selectedIndex),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/profile', arguments: userData);
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(3.0),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.green,
                        width: 3.0,
                        style: BorderStyle.solid),
                    image: DecorationImage(
                      image: AssetImage(userData['avatar']),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget getBody() {
    if (_selectedIndex == 0) {
      return ProfileBody(userData);
    }
    if (_selectedIndex == 1) {
      return LookUp(userData['id']);
    }
    if (_selectedIndex == 2) {
      return Text('2');
    }

    return Text('error');
  }
}

class ProfileBody extends StatelessWidget {
  final Map userData;
  ProfileBody(this.userData);

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
              width: 250,
              height: 250,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: new DecorationImage(
                  image: AssetImage(userData['avatar']),
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
                    Text(userData['location']),
                  ],
                ),
                SizedBox(height: 35),
                Text(userData['description'], style: TextStyle(fontSize: 15)),
              ], crossAxisAlignment: CrossAxisAlignment.start),
            ),
          ],
        ),
      ),
    );
  }
}

class LookUp extends StatelessWidget {
  final int userID;

  LookUp(this.userID);

  List<People> peopleList(userID, {location}) {
    List<People> result = List<People>();
    for (var i in UserData.getPeople(location: location)) {
      if (i['id'] != userID) {
        result.add(
          People(i['id'], i['username'], i['avatar'], i['location']),
        );
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 20,
            spacing: 20,
            children: peopleList(userID, location: null),
          ),
        ),
      ),
    );
  }
}

class People extends StatelessWidget {
  final String _username;
  final String _avatar;
  final String _location;
  final int _id;

  People(this._id, this._username, this._avatar, this._location);

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
            Navigator.of(context)
                .pushNamed('/profile', arguments: UserData(_id).userData);
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
                    image: AssetImage(_avatar),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                _username,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(_location),
            ],
          ),
        ),
      ),
    );
  }
}
