import 'dart:async';

import 'package:flutter/material.dart';
<<<<<<< HEAD
//import 'package:login_ui/src/model/userDB.dart';
=======
import 'package:login_ui/screen/home/tabs/peopletiles.dart';
>>>>>>> backend
import 'package:login_ui/screen/home/tabs/myprofile.dart';
import 'package:login_ui/screen/home/tabs/search.dart';
import 'package:login_ui/screen/home/tabs/settings.dart';
import 'package:login_ui/src/getdata.dart';

class MyHomePage extends StatefulWidget {
  final int myUserID;
  MyHomePage({this.myUserID});

  @override
  _MyHomePageState createState() => _MyHomePageState(myUserID);
}

class _MyHomePageState extends State<MyHomePage> {
  final int myUserID;

  _MyHomePageState(this.myUserID);
  Future<List<People>> peopleList;

  void initState() {
  super.initState();
  }
  int _selectedIndex = 0;
  void initState() {
    super.initState();
  }

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
      peopleList = fetchPeople(myUserID, location: '1');
    });
  }

  List<Widget> screens;

  Widget getBody() {
    if (_selectedIndex == 0) {
      return FutureBuilder(
        future: profileData(myUserID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            );
          } else {
            return ProfileBody(snapshot.data);
          }
        },
      );
    }
    if (_selectedIndex == 1) {
      return StreamBuilder<Object>(
          stream: Stream.fromFuture(peopleList),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            } else {
              return LookUp(snapshot.data);
            }
          });
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
                profileData(myUserID).then((userData) {
                  Navigator.of(context)
                      .pushNamed('/profile', arguments: userData);
                });
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
