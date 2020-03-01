import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtualorder_app/literals.dart';
import 'package:virtualorder_app/testSupport/dbRecordsGenerator.dart';
import '../database.dart';
import 'login.dart';
import '../model/user.dart';
import 'package:virtualorder_app/pages/locallist.dart';
import 'package:virtualorder_app/model/local.dart';


class Home extends StatefulWidget{
  
  FirebaseUser _authUser; 
  User _user; 
  //Home(FirebaseUser user){
  Home(){
          
  }

  @override
  _HomePage createState() => new _HomePage(_user);
}

class _HomePage extends State{
  List<String> vLocals = ["Restaurante 1", "Restaurante 2"];
  List<String> vSubs = ["Test Restaurante 1", "Test Restaurante 2"];
  User _user; 

  _HomePage(User user){
      _user = user; 
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(Literals.appName),
      ),
      drawer: _appMenu(),
      body: _listLocals2(context),
    );
  }
  
  Widget _listLocals2(BuildContext context){
    List <Local> localsArray;
    
    // Todo read all user documents from
    // FirebaseDb db = FirebaseDb();
    /*
    Future<DocumentSnapshot> result =   db.getUser("1");
    var then = result.then((doc){
          var address = doc.data["address"];
          print("address: $address");

          var city = doc.data["city"];
          print("city: $city");

          var country = doc.data["country"];
          print("country: $country");
          
          var email = doc.data["email"];
          print("email: $email");

          var name = doc.data["name"];
          print("name: $name");

          var phone = doc.data["phone"];
          print("phone: $phone");

          var postalcode = doc.data["postalcode"];
          print("postalcode: $postalcode");

          var surname = doc.data["surname"];
          print("surname: $surname");

          var uid = doc.data["uid"];
          print("uid: $uid");

          Local local = new Local();

          local.initUserDataLocal(address, city, country, email, name, phone, postalcode, surname, uid)
          localsArray.add(local);
          return Local;
        });
    


    return LocalList (locals: localsArray);
    */

    return LocalList(
      locals: <Local>[
        getLocal(0),
        getLocal(1),
        getLocal(2),
        getLocal(3),
      ],
    );
  }

  Local getLocal (int iLocalNumber){

    DbRecordsGenerator record = DbRecordsGenerator();
    List<String> localData = record.generateLocal(iLocalNumber);
    Local local = new Local();
    local.initUserDataLocal(localData[0], localData[1], localData[2], localData[3], localData[4],
        localData[5], localData[6], localData[7], localData[8]);
    return local;
  }


  Widget _listLocals(BuildContext context){
    List<Widget> items = List();
    for (int i = 0; i<vLocals.length;i++){
      Card card = Card(
        color:Colors.grey,
        child: Column(children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(8.0),
            width: 150,
            height: 150,
            child: Image.network("https://i.pinimg.com/474x/6a/d8/19/6ad819137caff58f0600c52395c3304d.jpg")),        
            new Container(            
              child:  Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(vLocals[i]),
                      subtitle: Text(vSubs[i]),      
                    ) ,
                  ],
              )
          )               
        ],),
      );      
      items.add(card);
    }
    return ListView(children: items);
  }

  Widget _appMenu(){
    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text("_user.name"),
            accountEmail: Text("_user.email"),
          ),
          ListTile(
            title: Text("Opción 1"),
            onTap: (){},
          ),
          ListTile(
            title: Text("Opción 2"),
            onTap: (){},
          ),
          ListTile(
            title:Text(Literals.closeSession),
            onTap: (){_closeSession();},

          )
        ],
      ),
    );
  }
  void _closeSession(){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(Literals.appName)));  
  }


}

