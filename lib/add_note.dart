// ignore_for_file: prefer_const_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addNote extends StatefulWidget{
  User user;
  addNote(this.user);
  @override
  State<addNote> createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  Divider div = const Divider(thickness:1,color: Colors.transparent);
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController(),
        desc = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Text("Title",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              div,
              TextFormField(
                controller: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              div,
              const Text("Description",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              div,
              TextFormField(
                controller: desc,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              div,
              loading?Center(child: CircularProgressIndicator(color: Colors.green,)):Container(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: TextButton(onPressed: ()async{
                    if(title.text=="" || desc.text=="") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields required!!"),backgroundColor: Colors.red,));
                    } else{
                      setState(() {
                        loading=true;
                      });
                      await firestoreService().insertNote(title.text,desc.text,widget.user.uid);

                      setState(() {
                        loading=false;
                      });
                      Navigator.pop(context);
                    }

                  }, 
                      child: Text("   Add Note   ",style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                      style: TextButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}