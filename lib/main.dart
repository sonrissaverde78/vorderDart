import 'package:flutter/material.dart';
import 'package:virtualorder_app/database.dart';
import 'package:virtualorder_app/pages/home.dart';
import 'package:virtualorder_app/pages/login.dart';
import 'package:virtualorder_app/pages/home.dart';

void main(){
  print("===> main starts");
 runApp(MyApp());
  
  FirebaseDb db = FirebaseDb();

  db.initUsers();
  //db.initTestRecords();
  //db.init();
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
<<<<<<< HEAD
      home: Login("VirtualOrder")   
=======
      home: Login("VirtualOrder")
      // home: Home()
>>>>>>> 6d0e948cced0ca1ea763205c439bf4065428f6f8
    );

   
  }
}

