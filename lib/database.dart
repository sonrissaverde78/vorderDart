import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/profile.dart';

import 'model/local.dart';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtualorder_app/model/profile.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtualorder_app/literals.dart';

import 'package:virtualorder_app/testSupport/dbRecordsGenerator.dart';

class FirebaseDb{

  FirebaseAuth _auth = FirebaseAuth.instance;

  initTestRecords() {
    print("===> FirebaseDb initTestRecords starts");
    DbRecordsGenerator testRecords = DbRecordsGenerator();
    testRecords.initTestRecords();
  }

  initUsers(){

    Future<DocumentSnapshot> result = getUser("7l62RDjEaQJzbjN0SVY6");
    result.then((doc){
          var name = doc.data["name"];
          print("capacity: $name");

          var capacity = doc.data["capacity"];
          print("capacity: $capacity");

        });

    return;

  }

  Future<DocumentSnapshot> getUser(String userDocument){
  
    print("FirebaseDb initUsers starts");
    Future<DocumentSnapshot> result = Firestore.instance.collection("users").document(userDocument).get();
    return result;
  
  }
}
