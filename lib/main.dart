// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authservice.dart';
import 'loginpage.dart';
import 'register.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: AuthService().auth.authStateChanges(),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.hasData)
            return LoginPage(snapshot.data);
          return RegisterSc();
        },
      )
    );
  }
}