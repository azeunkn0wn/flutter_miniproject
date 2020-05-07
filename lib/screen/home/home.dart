import 'package:flutter/material.dart';
//import 'package:login_ui/src/model/userDB.dart';
import 'package:login_ui/screen/home/tabs/myprofile.dart';
import 'package:login_ui/screen/home/tabs/search.dart';
import 'package:login_ui/screen/home/tabs/settings.dart';

class MyDashBoard extends StatefulWidget {
  final Map myUserData;
  MyDashBoard({this.myUserData});

  @override
  _MyDashBoardState createState() => _MyDashBoardState(myUserData);
}

class _MyDashBoardState extends State<MyDashBoard> {
  final myUserData;

  _MyDashBoardState(this.myUserData);

  void initState() {
  super.initState();
  }
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Text(
      'My Profile',
      style: optionStyle,
    ),
    Text(
      'Look up',
      style: optionStyle,
    ),
    Text(
      'Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screens;

  Widget getBody() {
    if (_selectedIndex == 0) {
      return ProfileBody(myUserData);
    }
    if (_selectedIndex == 1) {
      return LookUp(myUserData['user_id']);
    }
    if (_selectedIndex == 2) {
      return SettingsTab();
    }

    return Text('error');
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
                    .pushNamed('/profile', arguments: myUserData);
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
                      image: AssetImage('assets/login_logo.gif'),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: [ProfileBody(myUserData), LookUp(myUserData['user_id']), SettingsTab()]
      ),
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
}
