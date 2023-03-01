// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'authservice.dart';
import 'loginpage.dart';

class LoginP extends StatefulWidget{
  @override
  _loginScreen createState()=>_loginScreen();
}
class _loginScreen extends State<LoginP>{
  TextEditingController econt= TextEditingController(),pcont= TextEditingController();
  bool loading =false;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title:null,
      backgroundColor: const Color.fromARGB(190, 41, 213, 90),
      elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(190, 41, 213, 90),
                  Color.fromARGB(235, 5, 200, 34),
                  Color.fromRGBO(0, 410, 10,15)
                ],
              )
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 50
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text('Sign In',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 40
                    ),),
                    padding: EdgeInsetsDirectional.all(35),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:30,right:20,bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 25
                        ),
                      ],
                    ),
                    child:TextField(
                      style: TextStyle(color: Colors.white),
                      controller: econt,
                      cursorColor: Colors.greenAccent,
                      decoration: const InputDecoration(

                          border: InputBorder.none,
                          fillColor: Colors.black,
                          focusColor: Colors.greenAccent,
                          prefixIcon: Icon(
                            Icons.mail_outline_sharp,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white60,fontSize: 18)
                      ),
                    ),
                  ), Container(height:15),
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 35
                          ),],
                      ),
                    padding: EdgeInsets.only(left:30,right:20,top: 5,bottom: 12),
                      child:TextFormField(
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: pcont,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(color: Colors.white60,fontSize: 18)
                      ),
                    ),
                  ), Container(height:15),
                  loading? CircularProgressIndicator(): ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    onPressed: ()async {
                      setState(() {
                        loading = true;
                      });
                      if(econt.text=="" || pcont.text=="")
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter all fields!!"),
                          backgroundColor: Colors.redAccent,));
                      else {
                        User? res = await AuthService().login(
                            econt.text, pcont.text, context);
                        if(res != null)
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>LoginPage(res)),(route)=>false);
                      }
                      setState(() {
                        loading = false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Login successful!!"),backgroundColor: Colors.green));
                      });
                    },
                    child: Text("Login",style: TextStyle(
                        fontSize: 25,
                        color: Colors.green
                    ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}