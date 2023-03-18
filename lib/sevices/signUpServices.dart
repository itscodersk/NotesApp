// ignore_for_file: avoid_print, prefer_const_constructors, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homeScreen.dart';

signUpUser(
  String userName,
 String userPhone,
  String userEmail,
   String userPassword
   )async{

    User? userid = FirebaseAuth.instance.currentUser;

    try{
    await FirebaseFirestore.instance
                            .collection("users")
                            .doc(userid!.uid)
                             .set({
                            'userName': userName,
                            'userPhone': userPhone,
                            'userEmail': userEmail,
                           'CreatedAt': DateTime.now(),
                           'UserId':userid.uid,
                          }).then((value) => {
                            FirebaseAuth.instance.signOut(),
                            Get.to(()=> HomeScreen()),
                          }
                          );
    } on FirebaseAuthException catch (e){
      print("Error $e");
    }                     
   }                      