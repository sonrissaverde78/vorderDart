import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'home.dart';
import 'register.dart';
import 'package:virtualorder_app/literals.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget
{
  String _appName;
  
  Login(this._appName);
  String get appName =>_appName; 
  _LoginPageState createState() => new _LoginPageState(); 
}

class _LoginPageState extends State<Login>
{
  String _user, _password;  
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();  
  GoogleSignIn googleSignIn = new GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._appName),
      ),
      body:       
      Center(                     
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,   
            children: <Widget>[
              TextFormField(
                initialValue: "test@test.com",
                validator: (value){
                },
                onSaved: (val)=> _user = val,
                decoration: InputDecoration(
                  labelText: Literals.userName
                ),
              ),
              TextFormField(
                initialValue: "123456",
                validator: (value){
                },
                onSaved: (val)=> _password = val,
                decoration: InputDecoration(
                  labelText: Literals.userPass
                ),
                obscureText: true,
                ),
                SizedBox(
                  child: RaisedButton(onPressed: doLogin,child: Text(Literals.doLogin)),
                  width: double.infinity,
                ),        
                SizedBox(
                  child: GoogleSignInButton(darkMode: true,onPressed: doLoginGoogle),
                  width: double.infinity,
                ), 
                SizedBox(
                child: FacebookSignInButton(onPressed: (null)),
                width: double.infinity,
                ),
                FlatButton (
                  child: Text(Literals.register),
                  onPressed: doRegister,
                  )                   
            ],
        ),
      ),      
      ));
  }

  Future<void>_loadMainPage(FirebaseUser user) async{    
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(user)));  
  }

  Future<void> doLogin() async
  {
    final FormState state = _formKey.currentState;    
    if (state.validate())
    {
      state.save();
      try{
        AuthResult result  = await _auth.signInWithEmailAndPassword(email: _user, password: _password);
        FirebaseUser user = result.user;         
        print("Email: " + user.email);
        if (!result.user.isAnonymous){
          await _loadMainPage(user);
        }
          
      }
      catch(e){
          print(e.toString());
          Fluttertoast.showToast(
            msg: Literals.wrongUserPass,
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
  
  Future<void> doLoginGoogle() async {
    try{
       GoogleSignInAccount account = await googleSignIn.signIn();
       GoogleSignInAuthentication gAuth = await account.authentication;     
       final AuthCredential credential = GoogleAuthProvider.getCredential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);
       final AuthResult authResult = await _auth.signInWithCredential(credential);
       final FirebaseUser user = authResult.user;       
       print("User name: "+user.displayName);      
      //  await _loadMainPage(user);
    }
    catch(e){
      print("=======>Error ${e.toString()}");
    }    
  }

  void doRegister(){
    Navigator.push(context, MaterialPageRoute( builder: (context) => Register()));
  }
}