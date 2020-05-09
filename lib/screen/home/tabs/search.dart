import 'package:flutter/material.dart';

class LookUp extends StatelessWidget {
  final peopleList;
  LookUp(this.peopleList);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 20,
          spacing: 20,
          children: peopleList,
        ),
      ),
    );
  }
}



