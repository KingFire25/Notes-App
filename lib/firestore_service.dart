// ignore_for_file: empty_catches, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String title, String desc,String uid)async{
    try{
      await firestore.collection('users').add({
        "title":title,
        "description":desc,
        "user_id":uid
      });
    }catch(e){}
  }
  Future updateNote(String title, String desc,String doc)async{
    try{
      await firestore.collection('users').doc(doc).update({'title':title,'description':desc});
    }catch(e){}
  }
  Future deleteNote(String docid)async{
    try{
      await firestore.collection('users').doc(docid).delete();
    }catch(e){}
  }
}