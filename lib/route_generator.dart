import 'package:flutter/material.dart';
import 'package:login_ui/screen/login/login.dart';
import 'package:login_ui/screen/home/home.dart';
import 'package:login_ui/screen/profile/profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => MyDashBoard(myUserData: args),
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
