import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/profile.dart';

import 'model/local.dart';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtualorder_app/model/profile.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtualorder_app/literals.dart';

class FirebaseDb{

  FirebaseAuth _auth = FirebaseAuth.instance;

  initTestRecords() {
    print("===> FirebaseDb initTestRecords starts");
    for (int i=0;i<10;i++)
      RegisterLocalTest(i);
  }


  initUsers(){
    print("FirebaseDb initUsers starts");
    Future<DocumentSnapshot> result = Firestore.instance.collection("users").document("7l62RDjEaQJzbjN0SVY6").get();
    result.then((doc){
        var capacity = doc.data["capacity"];
        print("capacity: $capacity");
      });
  }

  Future<void> RegisterLocalTest(int iLocalNumber) async
  {
    print("===> FirebaseDb doLocalRegister 2 starts");
    {

      try {

        List<String> localData = generateLocal(iLocalNumber);
        String _email= localData[3];
        String _pass= localData[14];

        print("=====> authorizing mail: $_email");
        print("=====> with password   : $_pass");
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: _email, password: _pass);
        FirebaseUser authUser = result.user; 
        String auxEmail = authUser.email;
        String auxUid = authUser.uid;
        print("=====> authUser.email: $auxEmail");
        print("=====> authUser.uid   : $auxUid");
        
        print("===> FirebaseDb doLocalRegister 10s");
        Local local = new Local();
        print("===> FirebaseDb doLocalRegister 15s");

        local.initUserDataLocal(localData[0], localData[1], localData[2], authUser.email, localData[4],
            localData[5], localData[6], localData[7], authUser.uid);

        print("===> FirebaseDb doLocalRegister 30s");

        local.initLocalData( localData[9], localData[10], localData[11], localData[12], localData[13]);

        print("===> FirebaseDb doLocalRegister 50s");

        Profile profile = new Profile(null,local);
        print("$profile");
        profile.saveLocal();


      } catch (e) {
        print("===> Registration error: $e");
      }

    }
  }

  Future<void> doRegister() async
  {

    try {


/*
      if (!authUser.isAnonymous){
        User user = new User();
        user.init(_name, _address, "", "", authUser.email, _name,   _phone, "", _surname, authUser.uid, "NORMAL USER"); 
        Profile profile = new Profile(user, null);
        profile.save(); 
      }
*/

    } catch (e) {
      print("===> Registration error: $e");
        Fluttertoast.showToast(
        msg: Literals.REGISTRATION_ERROR,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  List<String> generateLocal (int i){

    print("===> FirebaseDb generateLocal starts");
    List<String> vLocals = ["Rest address <$i>",
      "Res city <$i>",
      "Res conuntry <$i>",
      "emailres$i@virtualorder.es",
      "Res name <$i>",
      "$i",
      "Res postalCode <$i>",
      "Res surname <$i>",
      "Res uid <$i>",
      //"Res usertype <$i>", user type is burned as "NORMAL" or "LOCAL"

      // Restaurant Data
      "Res cif <$i>",
      "100",
      "Res geolocation <$i>",
      "Res localName <$i>",
      "Res logo <$i>",
      "123456"];

    print("===========================");
    print(vLocals.toString());
    print("===========================");
    return vLocals;
  }
}
