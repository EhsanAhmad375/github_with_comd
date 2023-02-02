import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/ui/firesStore/Income_Fetch_Data.dart';
import 'package:firebase_test/ui/firesStore/Upload_image.dart';
import 'package:firebase_test/ui/firesStore/add_expanse_firestore.dart';
import 'package:firebase_test/widgets/round_button.dart';
import 'package:flutter/material.dart';

import '../auth/loging_Screen.dart';
import 'Expense_Fetch_DataList.dart';
import 'add_income_firestore_data.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text("Money Managment"),
              actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login_Screen()));
                });
              },
              icon: Icon(Icons.logout)),
          SizedBox(
            width: 10,
          )
        ],
      ),

    body: Column(children: [
      SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            color: Colors.red.shade300,
            onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddFirestoreDataScreen()));

            },child: Text('Add Income'),),
          MaterialButton(
            
            color: Colors.red.shade300,
            onPressed: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Income_Fetch_Data()));
            },child: Text('Income Recored '),),
        ],
      ),
            SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            color: Colors.red.shade200,
            onPressed: (){
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Add_Expanse_Firestore()));

            },child: Text('Add Expense'),),
          MaterialButton(
            
            color: Colors.red.shade200,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Expense_Fetch_Data()));
            },child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Expense Record'),
            ),),
        ],
      ),
      RoundButton(Title: 'Images', color:Colors.amber,
       onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageUpload()))})
    ],),
    );
  }
}