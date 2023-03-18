// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: override_on_non_overriding_member, file_names, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/homeScreen.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();


}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPasswordController=TextEditingController();
  

  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        centerTitle:true,
        title: Text("Forgot Password"),
        // ignore: prefer_const_literals_to_create_immutables
      //  actions: [
        //  Icon(Icons.more_vert),
        //],
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 250.0,
                child:Lottie.asset("assets/38435-register.json")
                ),
                SizedBox(
                    height: 10.0,
                  ),
                
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: forgotPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(),
                      ),
                  ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                 
                  ElevatedButton(
                    onPressed: () async{
                      var forgotEmail = forgotPasswordController.text.trim();
                      try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).
                          then((value) => {
                            print("Email Sent!"),
                              Get.off(()=> HomeScreen()),                      //now it will go on login Screen.
                          });
                      }on FirebaseAuthException catch (e) {                        //if there is some error it will catch and show Error.
                        print("Error $e");
                      }
                    }, 
                    child: Text("Forgot Password"),
                    ),
              ],
          ),
        ),
      ), 
      );
  }
}

