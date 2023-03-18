// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unnecessary_null_comparison, unused_import, avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/createNoteScreen.dart';
import 'package:note_app/views/homeScreen.dart';

import 'editNoteScreen.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();


}

class _MainScreenState extends State<MainScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/first.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 14, 100, 162),
          title: Text("Home Screen"),
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.off(() => HomeScreen());
              },
              child: Icon(Icons.logout),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.hdqwalls.com/download/tree-galaxy-sky-8k-b7-800x1280.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("notes")
                .where("userId", isEqualTo: userId?.uid)
                .snapshots(),
            builder:
                (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something Went Wrong!");
              }

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text("No Data Found"));
              }

              if (snapshot != null && snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var note = snapshot.data!.docs[index]['note'];
                    var noteId = snapshot.data!.docs[index]['userId'];
                    var docId = snapshot.data!.docs[index].id;
                    return Card(
                      color: Color.fromARGB(255, 192, 222, 248)
                          .withOpacity(0.5),
                      child: ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => EditNoteScreen(),
                                      arguments: {
                                        'note': note,
                                        'docId': docId,
                                      }
                                      );
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection("notes")
                                      .doc(docId)
                                      .delete();
                                },
                                child: Icon(Icons.delete)),
                          ],
                        ),
                        title: Text(
                          note,
                        ),
                        subtitle: Text(noteId),
                      ),
                    );
                  },
                );
              }

              return Container();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => CreateNoteScreen());
          },
          icon: Icon(Icons.add),
          label: Text("Add Note"),
        ),
      ),
    );
  }
}
