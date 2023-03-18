// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: override_on_non_overriding_member, file_names, prefer_const_constructors, duplicate_ignore, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_local_variable, unused_import

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/sevices/signUpServices.dart';
import 'package:note_app/views/homeScreen.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();


}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController UserNameController = TextEditingController();
  TextEditingController UserPhoneController = TextEditingController();
  TextEditingController UserEmailController = TextEditingController();
  TextEditingController UserPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        centerTitle:true,
        title: Text("SignUp Screen"),
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
               
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: UserNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'UserName',
                      enabledBorder: OutlineInputBorder(),
                      ),
                  ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                   Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: UserPhoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone No',
                      enabledBorder: OutlineInputBorder(),
                      ),
                  ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: UserEmailController,
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
                 Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: UserPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password),
                       suffixIcon: Icon(Icons.visibility,),
                      ),
                  ),
                  ),
                   SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      var UserName = UserNameController.text.trim();
                      var UserPhone = UserPhoneController.text.trim();
                      var UserEmail = UserEmailController.text.trim();
                      var UserPassword = UserPasswordController.text.trim();

                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: UserEmail, password: UserPassword).then((value) => {
                          log("User Created"),
                          signUpUser(
                            UserName,
                            UserPhone,
                            UserEmail,
                            UserPassword,                 //Take it as required , without it , it will not get ahead.

                          )
                        });
                    }, 
                    child: Text("Sign Up"),
                    ),
                 
                   SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=> HomeScreen());
                    },
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Already have an account SignUp"),
                        ),
                        ),
                    ),
                  ) ,
              ],
          ),
        ),
      ), 
      );
  }
}

