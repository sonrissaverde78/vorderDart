import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtualorder_app/model/profile.dart';

import 'package:virtualorder_app/testSupport/dbRecordsGenerator.dart';

class FirebaseDb{

  FirebaseAuth _auth = FirebaseAuth.instance;

  initTestRecords() {
    print("===> FirebaseDb initTestRecords starts");
    DbRecordsGenerator testRecords = DbRecordsGenerator();
    testRecords.initTestRecords();
  }

  initUsers(){

    Future<DocumentSnapshot> result = getUser("7l62RDjEaQJzbjN0SVY6");
    result.then((doc){
          var name = doc.data["name"];
          print("capacity: $name");

          var capacity = doc.data["capacity"];
          print("capacity: $capacity");

        });

    return;

  }

  Future<DocumentSnapshot> getUser(String userDocument){
  
    print("FirebaseDb initUsers starts");
    Future<DocumentSnapshot> result = Firestore.instance.collection("users").document(userDocument).get();
        return result;
  
  }


  Future<QuerySnapshot> getUsersDocuments()  {

    print("FirebaseDb initUsers starts");
    Future<QuerySnapshot> result = Firestore.instance.collection("users").getDocuments();
    return result;
  }

  static List<DocumentSnapshot> documentId;

  static List<DocumentSnapshot> getDocumentIdListSnapshot (){
    return documentId;
  }

  static List<DocumentSnapshot> dbUserIdList(){

    FirebaseDb db = FirebaseDb();

    
    Future<QuerySnapshot> userDocsId = db.getUsersDocuments();
    userDocsId.then(
      (doc){
        documentId = doc.documents;
        int totalUsers = documentId.length;
        print ('Total Users in Firestore:$totalUsers');
        documentId.asMap().forEach((index, value) {
          String aux = value.documentID;
          print ('value : $aux');
          print ('         '); 
        });
      }
    );
    return documentId;
  }


  static List<DocumentSnapshot> localList;

  static List<DocumentSnapshot> getlocalListSnapshot (){
    return localList;
  }

  static void dbLocalList (){
    Firestore.instance.collection('users').where("usertype", isEqualTo: "LOCAL")
    .snapshots()
    .listen((data) {
        localList = data.documents;
        data.documents.forEach((doc) { 
          print("name *********** "+doc["name"]);
          }
        );
      }
    );
  }
}