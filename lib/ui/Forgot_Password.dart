import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:firebase_test/widgets/round_button.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    final emailController=TextEditingController();
    final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email'
            ),
          ),
          SizedBox(height: 40,),
          
          RoundButton(Title: 'Forgot', color:Colors.grey, onTap: (){
            auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
              Utils().toastMessage('We have sand  your email,Please check email');
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });
          })
        ],
      ),
    );
  }
}