import 'package:firebase_test/firebase_serveses/Splash_Serveses.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashservices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashservices.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Money Managment ',
            style: TextStyle(fontSize: 50,
            fontFamily: 'cursive',
            color: Colors.red.shade300
            ),
          ),
        ),
      ),
    );
  }
}
