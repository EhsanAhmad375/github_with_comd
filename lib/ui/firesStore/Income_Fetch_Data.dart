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

class Income_Fetch_Data extends StatefulWidget {
  const Income_Fetch_Data({super.key});

  @override
  State<Income_Fetch_Data> createState() => _Income_Fetch_DataState();
}

class _Income_Fetch_DataState extends State<Income_Fetch_Data> {
  final auth = FirebaseAuth.instance;
  final myDesUpdate = TextEditingController();
  final MyFireFtore =
      FirebaseFirestore.instance.collection('Income').snapshots();
  final ref1 = FirebaseFirestore.instance.collection('Income');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red.shade300,
        title: Text('Income Data'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: MyFireFtore,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 200),
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text('Some error');
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                            },
                            title: Text('Rs.' +
                                  snapshot.data!.docs[index]['amount']
                                      .toString()),
                              subtitle: Text(snapshot
                                  .data!.docs[index]['description']
                                  .toString()),
                              leading:
                               Text(snapshot
                                  .data!.docs[index]['catagory']
                                  .toString()),
                              trailing: PopupMenuButton(
                                
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
                                        controller: myDesUpdate,
                                        decoration: InputDecoration(
                                          label: Text('Description'),
                                          hintText: 'Description',
                                        border: OutlineInputBorder()
                                        ),
                                        
                                      )),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Calcel")),
                                        TextButton(
                                            onPressed: () {
                                      ref1.doc(snapshot.data!.docs[index]['myId']
                                        .toString())
                                    .update({
                                  'description': myDesUpdate.text.toString()
                                }).then((value) {
                                  Utils().toastMessage('Updated');
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                });
                                myDesUpdate.clear();
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
                                      ref1.doc(snapshot.data!.docs[index]['myId']
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
                    })),
          ),
        ],
      ),
    );
  }
}
