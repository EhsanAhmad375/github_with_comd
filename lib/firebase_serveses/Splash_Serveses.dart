import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/ui/auth/loging_Screen.dart';
import 'package:firebase_test/ui/firesStore/Income_Fetch_Data.dart';
import 'package:firebase_test/ui/firesStore/HomePage.dart';
import 'package:firebase_test/ui/posts/post_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => Login_Screen())));
    }
  }
}
