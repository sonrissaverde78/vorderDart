import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtualorder_app/literals.dart';
import 'package:virtualorder_app/testSupport/dbRecordsGenerator.dart';
import 'package:virtualorder_app/model/userslist.dart';

import '../database.dart';
import 'login.dart';
import '../model/user.dart';
import 'package:virtualorder_app/pages/localListWidget.dart';
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
    
    // TODO: read all user documents from database.
    List <Local> localsArray;
    LocalList.initLocalsList(FirebaseDb.getlocalListSnapshot());
    LocalList.generateLocalList();
    localsArray = LocalList.getLocalList();
    // LocalList.initUsersList(FirebaseDb.getDocumentIdListSnapshot());
    // LocalList.generateDocIdList();
    

    return LocalListWidget(locals: localsArray);
/*
    return LocalListWidget(
      locals: <Local>[
        getLocal(0),
        getLocal(1),
        getLocal(2),
        getLocal(3),
      ],
    );
*/
  }

  Local getLocal (int iLocalNumber){

    DbRecordsGenerator record = DbRecordsGenerator();
    List<String> localData = record.generateLocal(iLocalNumber);
    Local local = new Local();
    local.initUserDataLocal(localData[0], localData[1], localData[2], localData[3], localData[4],
        localData[5], localData[6], localData[7], localData[8]);
    return local;
  }

/*
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
*/
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

