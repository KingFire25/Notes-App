import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> register(String email,String password,BuildContext context)async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.redAccent,));
    }
  }

  Future<User?> login(String email,String password,BuildContext context) async{
    try{
    UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.redAccent,));
  }
  }
  Future<User?> signGoogle()async{
    try{
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    if(user!=null){
      final GoogleSignInAuthentication authG = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: authG.accessToken,
        idToken: authG.idToken
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);
      return userCredential.user;
    }
    }catch(e){
      print(e);
    }
  }
  Future signOut() async{
    await auth.signOut();
    await GoogleSignIn().signOut();
  }
}

