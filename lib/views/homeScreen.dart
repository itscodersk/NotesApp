// ignore_for_file: prefer_const_constructors, unused_import, avoid_unnecessary_containers, depend_on_referenced_packages, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/forgotPasswordScreen.dart';
import 'package:note_app/views/mainScreen.dart';
import 'package:note_app/views/signUpScreen.dart';
import 'package:flutter_image/flutter_image.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.blue[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // backgroundColor: Color.fromARGB(255, 37, 20, 183),
          automaticallyImplyLeading: false,
          centerTitle:true,
          title: Text("Login Screen"),
          backgroundColor: Colors.blue[700],
        ),
        body: Container(
            decoration: BoxDecoration(image: DecorationImage(image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOwEJncJ-4ZK_PnrjooPBnO1-u_p6rYCEh0Q&usqp=CAU'),fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 300.0,
                  child: Lottie.asset("assets/38435-register.json"),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: loginEmailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: loginPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.star),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    var loginEmail = loginEmailController.text.trim();
                    var loginPassword = loginPasswordController.text.trim();

                    try {
                      final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginEmail, password: loginPassword)).user;
                      if (firebaseUser != null) {
                        Get.to(() => MainScreen());
                      } else {
                        print("Check Email and Password");
                      }
                    } on FirebaseAuthException catch (e) {
                      print("Error $e");
                    }
                  },
                  child: Text("Login"),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ForgotPasswordScreen());
                  },
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Forgot Password?"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Don't have an account SignUp"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
