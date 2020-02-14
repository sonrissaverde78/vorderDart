import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'register.dart';
// import '../pages/shop/homeShop.dart';
// import '../pages/client/homeClient.dart';
// import 'package:waitingqueue/model/profile.dart';
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
                  labelText: "User name"
                ),
              ),
              TextFormField(
                initialValue: "123456",
                validator: (value){
                },
                onSaved: (val)=> _password = val,
                decoration: InputDecoration(
                  labelText: "Password"
                ),
                obscureText: true,
                ),
                SizedBox(
                  child: RaisedButton(onPressed: doLogin,child: Text("Sign in")),
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
                  child: Text("Register as new user"),
                  onPressed: doRegister,
                  )                   
            ],
        ),
      ),      
      ));
  }

// Future<void>_loadMainPage(FirebaseUser user) async{
//     Profile profile = new Profile(user);
//     await profile.load(); 
//     if (profile.isClient == "1"){
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeClient(user, profile)));
//     }else{
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeShop(user, profile)));
//     }
    
// }

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
        // await _loadMainPage(user);
      }
      catch(e){
          print(e.toString());
      }
    }
  }
  
  Future<void> doLoginGoogle() async
  {
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

  void doRegister()
  {
    Navigator.push(context, MaterialPageRoute( builder: (context)=>Register()));
  }

}