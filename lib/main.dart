

import 'package:flutter/material.dart';
import 'package:virtualorder_app/database.dart';
import 'package:virtualorder_app/pages/home.dart';


import 'package:virtualorder_app/pages/splashScreen.dart';



void main() {

  print("===> main starts");
  runApp(MyApp());
  FirebaseDb.dbLocalList();
  FirebaseDb.dbUserIdList();
  FirebaseDb db = FirebaseDb();
  db.initUsers();

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (new MaterialApp(
      home: new SplashScreen(),// title: 'VirtualOrder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),  
      // home: Login("VirtualOrder")
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new Home(null)
      },
    )
    );
  }
}
