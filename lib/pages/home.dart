import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtualorder_app/literals.dart';
import 'login.dart';
import '../model/user.dart';
import '../model/profile.dart';

class Home extends StatefulWidget{
  
  FirebaseUser _authUser; 
  User _user; 
  Home(FirebaseUser user){
      _authUser = user; 
       //_user = await Profile.loadProfile(_authUser);
     
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
        title: Text(Literals.APP_NAME),
      ),
      drawer: _appMenu(),
      body: _listLocals(context),
    );
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
            title:Text(Literals.CLOSE_SESSION),
            onTap: (){_closeSession();},

          )
        ],
      ),
    );
  }
  void _closeSession(){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(Literals.APP_NAME)));  
  }


}

  
