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


class Home extends StatefulWidget {
  
  FirebaseUser _authUser; 
  User _user; 

  Home(FirebaseUser authUser){
       _user = new User();

       if (authUser != null){
        this._authUser = authUser;
        this._user.email = 'Usuario: '+authUser.email;
        if (authUser.displayName != null)
          this._user.name = 'Nombre: '+ authUser.displayName; 
        else
          this._user.name = ''; 
       }
       else{
        this._user.email = 'anonimo@anon.free';
        this._user.name = 'Anonimo';
       }

  }

  @override
  _HomePage createState() => new _HomePage(this._user);
}

class _HomePage extends State<Home>{

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
    LocalList.initLocalsList(FirebaseDb.getlocalListSnapshot());
    LocalList.generateLocalList();
    localsArray = LocalList.getLocalList();

    return LocalListWidget(locals: localsArray);

  }

  // generate a test record.
  Local getLocal (int iLocalNumber){

    DbRecordsGenerator record = DbRecordsGenerator();
    List<String> localData = record.generateLocal(iLocalNumber);
    Local local = new Local();
    local.initUserDataLocal(localData[0], localData[1], localData[2], localData[3], localData[4],
        localData[5], localData[6], localData[7], localData[8]);
    return local;
  }

  Widget _appMenu(){
    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(_user.name),
            accountEmail: Text(_user.email),
          ),
          ListTile(
            title: Text(Literals.options),
            onTap: (){},
          ),
          ListTile(
            title: Text(Literals.doLogin),
            onTap: (){_login();},
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

 void _login(){
       //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(Literals.appName)));  
           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login(Literals.appName)),
                    );
  }

}

