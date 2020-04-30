class UserData {
  static List userDataMap = [
    {
      'id': 0,
      'username': 'azeunkn0wn',
      'location': 'capiz',
      'avatar': 'assets/avatar/aze.png',
      'achievements': [],
      'description': 'null',
    },
    {
      'id': 1,
      'username': 'Mim',
      'location': 'iloilo',
      'avatar': 'assets/avatar/mim.png',
      'achievements': [
        '3rd place at the Texting Competition',
        '5th place at the Competition of Looking at the Cell Phone the Longest while Laying Down',
        '2nd place at the Ramen Noodle Eating Competition',
      ],
      'description':
          "My name is ‘MiM’\n\nI got the nickname ‘Mobile Girl’ since I love the cell phone.\nA lot of people worry that I am too addicted to the cell phone.\n\nBut I am not addicted at all!\n\nI like other things besides the cell phone.\n\nWalking the dog (app)\nMaking a spaghetti (app)\nDrawing (app)\nPlaying the piano (app)\nSwimming (app)\n\nHmmmm...\n",
    },
    {
      'id': 2,
      'username': 'Yam',
      'location': 'capiz',
      'avatar': 'assets/avatar/yam.png',
      'achievements': [],
      'description': 'null',
    },
    {
      'id': 3,
      'username': 'Heart',
      'location': 'iloilo',
      'avatar': 'assets/avatar/heartcat.png',
      'achievements': [],
      'description': 'null',
    },
    {
      'id': 4,
      'username': 'Josetus',
      'location': 'aklan',
      'avatar': 'assets/avatar/Josetus.png',
      'achievements': [],
      'description': 'null',
    },
  ];

  int userID;

  UserData(this.userID);

  Map get userData {
    for (var i = 0; i < userDataMap.length; i++) {
      if (userID != null) {
        if (userID == userDataMap[i]['id']) {
          return userDataMap[i];
        }
      }
    }
    return null;
  }

  static List getPeople({location}) {
    List result = [];
    if (location != null) {
      for (final i in userDataMap) {
        if (i['location'] == location) {
          result.add(i);
        }
        
      }
      return result;
    }
    else {
      return userDataMap;
    }
  }

}
// final  loginData = [
//     {
//       'id': 0,
//       'email': 'azeunkn0wn@gmail.com',
//       'password': '12345678',
//     },
//     {
//       'id': 1,
//       'email': 'email1@gmail.com',
//       'password': 'pass1',
//     },
//     {
//       'id': 2,
//       'email': 'email2@gmail.com',
//       'password': 'pass2',
//     },
//     {
//       'id': 3,
//       'email': 'email2@gmail.com',
//       'password': 'pass2',
//     },
//   ];

//   final String email = 'azeunkn0wn@gmail.com';
//   final String password = '12345678';
//   int userID;

//   for (var i = 0; i < loginData.length; i++) {
//     if (loginData[i]['email'] == email){
//       if (loginData[i]['password'] == password){
//         userID= loginData[i]['id'];
//     }
//   }
//   }

//   print(userID);

// }
// // not used

//   final  loginData = [
//     {
//       'id': 0,
//       'email': 'azeunkn0wn@gmail.com',
//       'password': '12345678',
//     },
//     {
//       'id': 1,
//       'email': 'email1@gmail.com',
//       'password': 'pass1',
//     },
//     {
//       'id': 2,
//       'email': 'email2@gmail.com',
//       'password': 'pass2',
//     },
//     {
//       'id': 3,
//       'email': 'email2@gmail.com',
//       'password': 'pass2',
//     },
//   ];

//   final userData = [
//     {'id': 0, 'username': 'azeunkn0wn', 'location': null, 'description': null, 'avatar': null},
//     {'id': 1, 'username': 'user1'     , 'location': null, 'description': null, 'avatar': null},
//     {'id': 2, 'username': 'user2'     , 'location': null, 'description': null, 'avatar': null},
//     {'id': 3, 'username': 'user3'     , 'location': null, 'description': null, 'avatar': null},
//   ];

// class LoginData {
//   int _userID;
//   String _emailAddress;
//   String _password;

//   LoginData(this._emailAddress, this._password);

//   LoginData.withId(this._userID, this._emailAddress, this._password);

//   int get userID => _userID;

//   String get emailAddress => _emailAddress;

//   String get password => _password;

// set emailAddress(String newEmail) {
//   this._emailAddress = newEmail;
// }

// set password(String newPassword) {
//   this._password = newPassword;
// }

// Map<String, dynamic> toMap() {
//   var map = Map<String, dynamic>();
//   if (userID != null) {
//     map['id'] = _userID;
//   }
//   map['email'] = _emailAddress;
//   map['password'] = _password;
//   return map;
// }

// LoginData.fromMapObject(Map<String, dynamic> map) {
//   this._userID = map['id'];
//   this._emailAddress = map['email'];
//   this._password = map['password'];
// }
