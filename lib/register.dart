// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login1.dart';
import 'authservice.dart';
import 'loginpage.dart';
class RegisterSc extends StatefulWidget {
  @override
  State<RegisterSc> createState() => _RegisterScState();
}

class _RegisterScState extends State<RegisterSc> {
  TextEditingController econt= TextEditingController(),pcont= TextEditingController(),cpcont= TextEditingController();
  bool loading =false,loading1=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus)
          focus.unfocus();
      },
      child: Scaffold(
        body:Stack(
          children: <Widget>[
            Container(
              height: double.infinity,width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(116, 12, 44, 131),
                      Color.fromARGB(224, 16, 47, 149),
                      Color.fromARGB(246, 40, 66, 158),
                    ],
                  )
              ),
            ),
            Container(
              height: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            child:SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 50
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Container(
                    child: const Text('Register',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 40
                    ),),
                    padding: const EdgeInsetsDirectional.all(45),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left:30,right:20,bottom: 5),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 25
                        ),
                      ],
                    ),
                    child:TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: econt,
                      cursorColor: Colors.greenAccent,
                      decoration: const InputDecoration(
                          fillColor: Colors.black,
                          focusColor: Colors.greenAccent,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.mail_outline_sharp,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white60,fontSize: 18)
                      ),
                    ),
                  ), const SizedBox(height:15),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 35
                        ),],
                    ),
                    padding: const EdgeInsets.only(left:30,right:20,top: 5,bottom: 12),
                    child:TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: pcont,
                      decoration: const InputDecoration(
                        fillColor: Colors.black,
                        focusColor: Colors.greenAccent,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your Password',
                          hintStyle: TextStyle(color: Colors.white60,fontSize: 18)
                      ),
                    ),
                  ), const SizedBox(height:15),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 35
                        ),],
                    ),
                    padding: const EdgeInsets.only(left:30,right:20,top: 5,bottom: 12),
                    child:TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: cpcont,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Confirm your Password',
                          hintStyle: TextStyle(color: Colors.white60,fontSize: 18)
                      ),
                    ),
                  ), const SizedBox(height:15),
            Row(
              children:<Widget>[
                const Text('  Already have an account?',
                  style: TextStyle(color: Colors.white70 ,fontSize: 17),),
            TextButton(
              onPressed: () {
                Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginP()));
              },
              child: const Text("Login here",
              style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            ],
            ),Container(height:10),
            loading ? const CircularProgressIndicator(): SizedBox(
              height: 36,
              width: 120,
              child: TextButton(
                style:TextButton.styleFrom(
                elevation: 2,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  if(econt.text=="" || pcont.text=="" || cpcont.text=="")
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("All fields are rewuired !!"),backgroundColor: Colors.deepOrange,));
                  else if(pcont.text != cpcont.text)
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Passwords don't match !!"),backgroundColor: Colors.deepOrange));
                  else{
                    User? res = await AuthService().register(econt.text,pcont.text,context);
                    if(res!=null)
                     Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=>LoginPage(res)),(route)=>false);
                      }
                  setState(() {
                    loading = false;
                    if(econt.text != "" && pcont.text != "" && cpcont.text != "" && pcont.text == cpcont.text)
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Account created successfully!!"),backgroundColor: Color.fromARGB(255, 16, 208, 70)));
                  });
                },
                child: const Text("Submit", style: TextStyle(
                  fontSize: 18,
                ),),
              ),
            ),
            const Divider(),
              loading1? const CircularProgressIndicator(): ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                onPressed: () async{
                  setState(() {
                    loading1=true;
                  });
                await AuthService().signGoogle();
                setState(() {
                  loading1 = false;
                });
              },
                child: const Text("Sign in with Google",style: TextStyle(fontSize: 15,color: Colors.blue),),
              ),
            ],
            ),
            ),
            ),
      ],
      ),
      ),
    );
  }
}
