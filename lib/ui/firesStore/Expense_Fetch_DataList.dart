import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_test/ui/auth/loging_Screen.dart';
import 'package:firebase_test/ui/firesStore/add_income_firestore_data.dart';
import 'package:firebase_test/ui/posts/Add_Post.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:flutter/material.dart';

class Expense_Fetch_Data extends StatefulWidget {
  const Expense_Fetch_Data({super.key});

  @override  
  State<Expense_Fetch_Data> createState() => _Expense_Fetch_DataState();
}

class _Expense_Fetch_DataState extends State<Expense_Fetch_Data> {
  final auth = FirebaseAuth.instance;
  final exDesUpdate=TextEditingController();
   final MyFireFtores=FirebaseFirestore.instance.collection('Expanse').snapshots();
  final ref2=FirebaseFirestore.instance.collection('Expanse');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red.shade300,
        title: Text('Expanse Data'),
      ),

  body:  ListView(  
    children: [
        SizedBox(height: 10,),
      Container(
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: MyFireFtores,    
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 200),
                  child: CircularProgressIndicator(),
                );
              }
              
              if(snapshot.hasError){
                return Text('Some error');
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
              
                return ListTile(
                  onTap: (){
                    
                  },
                  title: Text('Rs.'+snapshot.data!.docs[index]['examount'].toString()),
                  subtitle: Text(snapshot.data!.docs[index]['exdescription'].toString()),
                  leading: Text(snapshot.data!.docs[index]['excatagory'].toString()),
                  trailing:PopupMenuButton(
                                
                                itemBuilder: (context) =>
                                    [
                                      PopupMenuItem(child: ListTile(
                                      leading: Icon(Icons.edit,
                                      color: Colors.red.shade300
                                      ),
                                      title: Text('Edit',
                                      style: TextStyle(color: Colors.red.shade300),
                                      ),
                                      onTap: (){
                                        showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Update'),
                                      content: Container(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              label: Text('Description'),
                                              border: OutlineInputBorder(),
                                              hintText: 'Description'),
                                        controller: exDesUpdate,
                                      )),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Calcel")),
                                        TextButton(
                                            onPressed: () {
                                      ref2.doc(snapshot.data!.docs[index]['exmyId']
                                        .toString())
                                    .update({
                                  'exdescription': exDesUpdate.text.toString()
                                }).then((value) {
                                  Utils().toastMessage('Updated');
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                });
                                exDesUpdate.clear();
                                Navigator.pop(context);
                                            },
                                            child: Text("Update"))
                                      ],
                                    );
                                  },
                                );
                               
                              },
                                    )),
                                    PopupMenuItem(child: TextButton(onPressed: (){
                                      ref2.doc(snapshot.data!.docs[index]['exmyId']
                                        .toString()).delete();
                                    },child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 20,),
                                        Text('Delete'),
                                      ],
                                    ),))
                                    ],
                              ), 
                
                );
              });
            }
          )       ),
      ),

      

          ],
        ),
      );
    }
  }