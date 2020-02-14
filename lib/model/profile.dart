

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
     var phone = _user.phone; 
     print("--> $phone");
     CollectionReference ref = Firestore.instance.collection("users");
     DocumentReference doc = ref.document("$phone");
     
     await doc.setData({
        "name":_user.name,
        "surname":_user.surname
    });

    //  await ref.add({
    //    "name":_user.name,
    //    "surname":_user.surname
    //  });
   });
    

    
  }


}