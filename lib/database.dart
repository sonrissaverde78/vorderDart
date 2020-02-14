import 'package:cloud_firestore/cloud_firestore.dart';



class FirebaseDb{

  
  auth(){
    
  }

  init(){
    print("init starts");
    Future<DocumentSnapshot> result = Firestore.instance.collection("users").document("7l62RDjEaQJzbjN0SVY6").get();
    result.then((doc){
        var capacity = doc.data["capacity"];
        print("capacity: $capacity");
      });
  }
}