import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
                onPressed: () {
                  //Navigator.of(context).pushReplacementNamed('/');
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                },
                child: Text('Log out')),
          )
        ], 
      ),
    );
  }
}
