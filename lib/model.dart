import 'package:cloud_firestore/cloud_firestore.dart';

class Model{
  String title;
  String desc;
  String userId;
  String docId;
  Model({
    required this.title,
    required this.desc,
    required this.userId,
    required this.docId}
  );
  factory Model.fromJson(DocumentSnapshot snapshot){
    return Model(
      title: snapshot['title'], 
      desc: snapshot['description'], 
      userId: snapshot['user_id'], 
      docId: snapshot.id
      );
  }
}