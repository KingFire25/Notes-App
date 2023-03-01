// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'firestore_service.dart';
import 'model.dart';

class editNote extends StatefulWidget {
  Model note;
  editNote(this.note);
  @override
  State<editNote> createState() => _editNoteState();
}

class _editNoteState extends State<editNote> {
  TextEditingController title = TextEditingController(),
      desc = TextEditingController();
    bool loading =false,load=false;
  Divider div = const Divider(thickness: 1, color: Colors.transparent);
  @override
  void initState() {
    title.text=widget.note.title;
    desc.text=widget.note.desc;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: load?CircularProgressIndicator(color: Colors.green,): Icon(Icons.delete,color: Colors.red,),
             onPressed: () async{
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm delete?"),
                    actions: [
                      TextButton(onPressed: (){Navigator.pop(context);}, child: Text("No")),
                      TextButton(onPressed: (){
                                firestoreService().deleteNote(widget.note.docId);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                },
                                child: Text("Yes")),
                    ],
                  );
                });
             })],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              div,
              TextFormField(
                controller: title,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              div,
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              div,
              TextFormField(
                controller: desc,
                maxLines: 5,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              div,
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Center(
                  child: loading?const CircularProgressIndicator(color: Colors.green,): TextButton(
                    onPressed: () async{
                      setState(() {
                        loading=true;
                      });
                      await firestoreService().updateNote(title.text, desc.text, widget.note.docId);
                      setState(() {
                        loading=false;
                      });
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,),
                    child: const Text("   Update  Note   ",
                        style: TextStyle(
                            color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
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
