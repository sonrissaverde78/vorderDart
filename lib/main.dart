import 'package:flutter/material.dart';
import 'package:virtualorder_app/database.dart';
import 'package:virtualorder_app/pages/login.dart';

void main(){
 runApp(MyApp());
  
  FirebaseDb db = FirebaseDb();
  db.init();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VirtualOrder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login("VirtualOrder")
    );

   
  }
}

