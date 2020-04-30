import 'package:flutter/material.dart';
import 'package:login_ui/screen/home/home.dart';
import 'package:login_ui/screen/login/login.dart';
import 'package:login_ui/screen/home/dash.dart';
import 'package:login_ui/screen/home/profile/profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushedNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => Home(userID: args),
          );
        }
        return _errorRoute();

      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/dash':
        return MaterialPageRoute(
          builder: (_) => MyDashBoard(userData: args),
        );
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => MyProfile(userData: args),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
