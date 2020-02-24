import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtualorder_app/literals.dart';
import 'login.dart';
import '../model/user.dart';
import '../model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      //body: _listLocals(context),
      body: _buildBody(context),
    );
  }
  Widget _buildBody (BuildContext context){
    return StreamBuilder<QuerySnapshot>(
    stream:Firestore.instance.collection("users").snapshots(),
    builder: (context, snapshot){
      if (!snapshot.hasData) return LinearProgressIndicator();
      return _buildlist(context, snapshot.data.documents);
    },
    );
  }

  Widget _buildlist(BuildContext context, List<DocumentSnapshot>snapshot){
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),

    );
  }
  Widget _buildListItem (BuildContext context, DocumentSnapshot data){

    final record = Record.fromSnapshot(data);

    return Padding(

      key: ValueKey(record.CIF),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border:Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),


      child: ListTile(
        title:Text(record.CIF),
        trailing: Text(record.address),
        //onTap: () => record.reference.updateData({'votes': FieldValue.increment(1)}),
       ),
     )
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

class Record {
  final String CIF, address, capacity; //, city, country, email, geolocation, logo, name, postalcode, restaurantname, tel, usertype;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['CIF'] != null),
        assert(map['address'] != null),
        assert(map['capacity'] != null),
  /*
        assert(map['city'] != null),
        assert(map['contry'] != null),
        assert(map['email]'] != null),
        assert(map['geolocation]'] != null),
        assert(map['logo]'] != null),
        assert(map['name]'] != null),
        assert(map['postalcode]'] != null),
        assert(map['restaurantname]'] != null),
        assert(map['tel]'] != null),
        assert(map['usertype]'] != null),
  */
        CIF = map['CIF'],
        address = map['address'],
        capacity = map['capacity'];

/*
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];
*/
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$CIF:$address>";
}



