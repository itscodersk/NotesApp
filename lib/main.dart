// ignore_for_file: unused_import, prefer_const_constructors, override_on_non_overriding_member, annotate_overrides, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homeScreen.dart';
import 'package:note_app/views/mainScreen.dart';
import '/homeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void instance(){
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());   //if we go again on app it will open Home Screen and when we signOut it will open on sign in screen.
  }
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user!= null ? const MainScreen() : const HomeScreen(),
    );
  }
}

