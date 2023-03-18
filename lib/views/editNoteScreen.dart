// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, unused_import, avoid_unnecessary_containers, unnecessary_string_interpolations, file_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:note_app/views/mainScreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
        title: Text("Edit Note",
        ),
      ),
      body: Container(
        child: Column(children: [
          TextFormField(
            controller: noteController
            ..text = "${Get.arguments['note'].toString()}",
          ),
          ElevatedButton(onPressed: ()async{                       //When we click to edit it only Update that one which we Want.
            await FirebaseFirestore.instance.collection("notes").doc(Get.arguments['docId'].toString()).update({
              'note':noteController.text.trim(),
            },
            ).then((value) => {
              Get.off(()=> MainScreen()),
                    log("Data Updated" as num),
            });
          }, 
          child: Text("Update")),
        ],
        ),
      ),
    );
  }
}