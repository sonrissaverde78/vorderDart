

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualorder_app/model/local.dart';

class LocalList {

  static List<DocumentSnapshot> documentIdList;
  static List<Local> usersList = new List() ;

  static void initUsersList (List<DocumentSnapshot> docIdList){
    documentIdList = docIdList;
  }

  static List<DocumentSnapshot> getDocIdList(){
    return documentIdList;
  }

  static void generateDocIdList(){

    documentIdList.asMap().forEach((index, value) {
          String aux = value.documentID;
          print ('value : $aux');
          print ('         '); 
          //List <Local> usersList = new List();
          var local = new Local();
          local.name = value.documentID;
          usersList.add(local);
          
        });
    
  }

  static List<Local> getDocumentIdList(){

    return usersList;
  }
}
