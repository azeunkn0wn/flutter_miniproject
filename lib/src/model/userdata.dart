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
        '3rd place at the Texting Competition\n5th place at the Competition of Looking at the Cell Phone the Longest while Laying Down\n2nd place at the Ramen Noodle Eating Competition'
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
    } else {
      return userDataMap;
    }
  }
}
