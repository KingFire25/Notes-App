// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_note.dart';
import 'authservice.dart';
import 'edit_page.dart';
import 'login1.dart';
import 'model.dart';

class LoginPage extends StatelessWidget{
  User user;
  LoginPage(this.user);
  FirebaseFirestore firestore = FirebaseFirestore.instance; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
         backgroundColor: Colors.green,
         title: const Text("Home",
           style: TextStyle(
           fontSize: 21
         ),),
         actions: [
           TextButton.icon(onPressed:()async{
             await AuthService().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginP()),
                    (route) => false);
           } , icon: const Icon(Icons.logout),label: const Text("Log Out",style: TextStyle(color: Colors.white),),
             style: TextButton.styleFrom(iconColor: Colors.white,foregroundColor: Colors.white),)
         ],
       ),
       body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('user_id',isEqualTo: user.uid).snapshots(),
        builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
                if(snapshot.data.docs.length>0){
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,index){
                      Model note = Model.fromJson(snapshot.data.docs[index]);
                      return Card(
                          margin: const EdgeInsets.all(8),
                          color: Colors.teal[400],
                          child: ListTile(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => editNote(note))),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            title: Text(note.title,style: GoogleFonts.actor(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            )),
                            subtitle: Text(note.desc,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 15),maxLines: 2,),
                          ),
                        );
                    });
                }
                else{
                  return const Center(child: Text("No notes available."),);
                }
            }
            return const SizedBox();
        }
        ),
       
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 2,
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>addNote(user)));
          },
        child: const Icon(Icons.add,color: Colors.white,),
        ),
    );
  }
}