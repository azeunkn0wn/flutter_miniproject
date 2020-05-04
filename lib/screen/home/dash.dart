import 'package:flutter/material.dart';
import 'package:login_ui/src/model/userDB.dart';

class MyDashBoard extends StatefulWidget {
  final Map myUserData;
  MyDashBoard({this.myUserData});

  @override
  _MyDashBoardState createState() => _MyDashBoardState(myUserData);
}

class _MyDashBoardState extends State<MyDashBoard> {
  final myUserData;

  _MyDashBoardState(this.myUserData);

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
      return ProfileBody(myUserData);
    }
    if (_selectedIndex == 1) {
      return LookUp(myUserData['user_id']);
    }
    if (_selectedIndex == 2) {
      return Text('''SettingsTab()''');
    }

    return Text('error');
  }
}

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
              width: 250,
              height: 250,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: new DecorationImage(
                  image: AssetImage(myUserData['avatar']),
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

    print(peopleList);
    return peopleList;
  }

// List<People> peopleList(userID, {location}) {

//   List<People> result = List<People>();
//   for (var i in UserData.getPeople(location: location)) {
//     if (i['id'] != userID) {
//       result.add(
//         People(i['id'], i['username'], i['avatar'], i['location']),
//       );
//     }
//   }

//   return result;
// }

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
          if (snapshot.hasData) {
            return Container(
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 20,
                    spacing: 20,
                    children: snapshot.data,
                  ),
                ),
              ),
            );
          }
        });
  }
}

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
            Navigator.of(context).pushNamed('/profile',
                arguments: null); //UserData(_id).userData);
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

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text('Location: '),
          TextField(),
        ],
      ),
    );
  }
}
