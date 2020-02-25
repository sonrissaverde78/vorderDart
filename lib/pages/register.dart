import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/profile.dart';
import '../model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:virtualorder_app/literals.dart';


class Register extends StatefulWidget {
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  String _address;
  String _name; 
  String _surname;   
  String _pass; 
  String _mail; 
  String _phone; 
  String _isClient;

  FirebaseAuth _auth = FirebaseAuth.instance;
  
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();  

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo usuario"),
      ),
      body:  Form(
          key: _formKey,
          child: Column(  
             children: <Widget>[
              TextFormField(            
                initialValue: "test",
                validator: (value){
                },                
                decoration: InputDecoration(              
                  labelText: "Nombre"
                ),
                onSaved: (val)=> _name = val,
              ), 

                TextFormField(            
                validator: (value){
                },         
                initialValue: "testSurname",       
                decoration: InputDecoration(
                  labelText: "Apellidos"
                ),
                onSaved: (val)=> _surname = val,
              ), 

                TextFormField(      
                  initialValue: "test@test.com",      
                validator: (value){
                },                
                decoration: InputDecoration(
                  labelText: "Mail"
                ),
                onSaved: (val)=> _mail = val,
              ), 

                TextFormField(        
                  initialValue: "123455",    
                validator: (value){
                },                
                decoration: InputDecoration(
                  labelText: "Teléfono"
                ),
                onSaved: (val)=> _phone = val,
              ), 

                TextFormField(      
                  initialValue: "123456",      
                validator: (value){
                },                
                decoration: InputDecoration(
                  labelText: "Contraseña",                
                ),
                obscureText: true,
                onSaved: (val)=> _pass = val,
              ), 

                TextFormField(        
                  initialValue: "1",    
                validator: (value){
                },                
                decoration: InputDecoration(
                  labelText: "Tipo (cliente -> 1 / comercio -> 0)"
                ),
                onSaved: (val)=> _isClient = val,
              ), 

              SizedBox(
                  child: RaisedButton(onPressed: doRegister,child: Text("Registrar")),
                  width: double.infinity,
                ),  
             ]
          ),
        )
        
    );
  }

  Future<void> doRegister() async
  {
      FormState state =_formKey.currentState; 
      if (state.validate())
      {
        state.save(); 
        try {
          print("=====> mail: $_mail");
          AuthResult result = await _auth.createUserWithEmailAndPassword(email: _mail, password: _pass);
          FirebaseUser authUser = result.user; 

          if (!authUser.isAnonymous){
            User user = new User();
            user.init(_address, "", "", authUser.email, _name,   _phone, "", _surname, authUser.uid, "NORMAL USER"); 
            Profile profile = new Profile(user, null);
            profile.save(); 
          }
            
        } catch (e) {
          print("===> Registration error: $e");
           Fluttertoast.showToast(
            msg: Literals.registrationError,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
          
      }
  }
}
