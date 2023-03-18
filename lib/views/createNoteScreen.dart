// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, annotate_overrides, override_on_non_overriding_member, unused_import, unnecessary_import, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:note_app/views/mainScreen.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}
class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("Create Note"),
        
      ),
      body: Container(
        
        decoration: BoxDecoration(image:
         DecorationImage(
          image: NetworkImage('https://e0.pxfuel.com/wallpapers/184/217/desktop-wallpaper-among-pink-sus-among-us-impostor-amongus-thumbnail.jpg'),
          fit: BoxFit.cover)
          ),
          

        margin: EdgeInsets.symmetric(
            horizontal: 10.0), // it will give some space from both the side.
        child: Column(
          children: [
            Container(
              
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Note"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var note = noteController.text.trim();
                if (note != "") {
                  try {
                    await FirebaseFirestore.instance  //here doc// will automatically create an user Id uniquelly.
                        .collection("notes")
                        .doc()
                        .set({
                      "createdAt": DateTime.now(),
                      "note": note,
                      "userId": userId?.uid,
                    });
                  } catch (e) {
                    print("Error $e");
                  }
                }
              },
              
              child: Text("Add Note"), //When i tap it will go on database.
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed:(){
    Get.to(()=> MainScreen());
  
  
  }, label: Text("Save"),
  icon: Icon(Icons.save),
  
    ),
    
    
    );
  }
}
