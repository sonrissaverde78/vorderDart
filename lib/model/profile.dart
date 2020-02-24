

import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Profile {

  User _user; 

  Profile (User user){
    this._user = user; 
  }

  void save(){
    print("saving profile");
   Firestore.instance.runTransaction((Transaction transaction) async{    
     CollectionReference ref = Firestore.instance.collection("users");
     DocumentReference doc = ref.document(_user.uid);
     
     await doc.setData({
        "name":_user.name,
        "surname":_user.surname
    });
   });  
  }

  static Future<User> loadProfile(FirebaseUser user){
      DocumentReference doc = Firestore.instance.collection("users").document(user.uid);
      User userInfo = User();
      doc.get().then((read) {
          userInfo.name = read.data["name"];
          userInfo.surname =  read.data["surname"];
          userInfo.email = read.data["mail"];
      });
      return null; 
  }


}