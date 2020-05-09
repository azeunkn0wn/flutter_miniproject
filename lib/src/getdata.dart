import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_ui/screen/home/tabs/peopletiles.dart';

authenticate(_username, _password, context) async {
  String url = 'http://192.168.1.100:8383/login';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"username": "$_username", "password": "$_password"}';
  var response = await http.post(url, headers: headers, body: json);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    print(body);
    return body;
  }
}

Future<Map> profileData(int id) async {
  Map userData;
  String url = 'http://192.168.1.100:8383/profile/$id';
  Map<String, String> headers = {"Content-type": "application/json"};
  var response = await http.get(url, headers: headers);
  
  if (response.statusCode == 200) {
    userData = jsonDecode(utf8.decode(response.bodyBytes));
  
    return userData;
  }
  return null;
}

Future<List<People>> fetchPeople(
  int myUserID, {
  String username,
  String location,
  int category,
}) async {
  List<People> peopleList = [];
  String url = 'http://192.168.1.100:8383/search';
  Map<String, String> headers = {"Content-type": "application/json"};
  if (username != null) {
    username = '"' + username + '"';
  }
  if (location != null) {
    location = '"' + location + '"';
  }
  String json =
      '{"myUserID": $myUserID, "username": $username, "location": $location, "category": $category}';
  var response = await http.post(url, headers: headers, body: json);
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    body.forEach((row) => {
          peopleList.add(People(
            id: row['userID'],
            username: row['username'],
            firstname: row['first_name'],
            avatar: row['avatar'],
            contact: row['contact'],
            location: row['location'],
            description: row['description'],
          ))
        });
    return peopleList;
  }
  return [];
}
