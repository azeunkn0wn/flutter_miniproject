import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:login_ui/screen/home/tabs/searchstate.dart';
import 'package:login_ui/src/model/userDB.dart';

class LookUp extends StatelessWidget {
  final int myUserID;
  LookUp(this.myUserID);

  

  @override
  Widget build(BuildContext context) {

    return Text('s');
    // return StreamBuilder<List<People>>(
    //   stream: byCategory(
    //           myUserID,
    //           location: '1',
    //           category: null,
    //           username: null,
    //         ),
    //         builder: (context, snapshot) {
    //           Widget child;
    //           if (snapshot.hasData) {
    //             child = Wrap(
    //               direction: Axis.horizontal,
    //               runSpacing: 20,
    //               spacing: 20,
    //               children: snapshot.data,
    //             );
    //           } else {
    //             child = Container(
    //               width: 0,
    //               height: 0,
    //             );
    //           }
    //           return Container(
    //             child: SingleChildScrollView(
    //               child: Center(
    //                 child: child,
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // );
  }
}

 
=======

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



>>>>>>> backend
