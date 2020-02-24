

import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualorder_app/model/local.dart';


class Profile {

  User _user;
  Local _userLocal;

  Profile (User user, Local userLocal){
    if (user == null){
      this._userLocal = userLocal;
      this._user = userLocal;
    }
      else{
        this._user = user;
    }
      
  }

  void save(){
   print("saving normal user profile");
   Firestore.instance.runTransaction((Transaction transaction) async{    
     CollectionReference ref = Firestore.instance.collection("users");
     DocumentReference doc = ref.document(_user.uid);
     
     await doc.setData({
        //"address":_userLocal.address,
        //"city":_userLocal.city,
        //"country":_userLocal.country,
        //"email":_userLocal.email,
        "name": _userLocal.name,
        //"phone":_userLocal.phone,
        //"postalcode":_userLocal.postalCode,
        "surname":_userLocal.surname,
        "usertype":_userLocal.userType,
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

  void saveLocal(){
    print("===> Profile saveLocal starts");
    Firestore.instance.runTransaction((Transaction transaction) async{

      CollectionReference ref = Firestore.instance.collection("users");
      DocumentReference doc = ref.document(_userLocal.uid);

      await doc.setData({
        "address":_userLocal.address,
        "city":_userLocal.city,
        "country":_userLocal.country,
        "email":_userLocal.email,
        "name": _userLocal.name,
        "phone":_userLocal.phone,
        "postalcode":_userLocal.postalCode,
        "surname":_userLocal.surname,
        "usertype":_userLocal.userType,

        "CIF":_userLocal.cif,
        "capacity":_userLocal.capacity,

        
        "geolocation":_userLocal.geolocation,
        "localName":_userLocal.localName,
        "logo":_userLocal.logo,
        

      });


    });

  }

}
