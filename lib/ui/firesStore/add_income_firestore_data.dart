import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/ui/firesStore/StaticClass.dart';
import 'package:firebase_test/ui/posts/StaticClass.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:firebase_test/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  final MyFireFtore=FirebaseFirestore.instance.collection('Income');
  final AmountController = TextEditingController();
  final CatagoryController = TextEditingController();
  final DescriptionController = TextEditingController();
  final OtherInformationController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Student Data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.red.shade300, title: Text('Add Income Data ')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: AmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Amonut",
                  label: Text('Amount')),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: CatagoryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Catagory",
                  label: Text('Catagory')
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            
            TextFormField(
              controller: DescriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description",
                  label: Text('Description')
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            // TextFormField(
            //   controller: OtherInformationController,
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: "Other Information",
            //       label: Text('Other Information')
            //       ),
            // ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                loading: loading,
                Title: 'Add Income',
                color: Colors.red.shade300,
                onTap: () {
                  setState(() {
                    loading=true;
                    // myStaticClass.i++;
                  });
                  String id=DateTime.now().millisecondsSinceEpoch.toString();
                  MyFireFtore.doc(id).set({
                      'myId':id,
                      'amount':AmountController.text.toString(),
                       'catagory':CatagoryController.text.toString(),
                       'description':DescriptionController.text.toString(),
                       

                      //  'Other':OtherInformationController.text.toString(),
                      
                  }).then((value){
                    Utils().toastMessage('Data Added');
                 setState(() {
                    loading=false;
                  });
                  }).onError((error, stackTrace){
                 setState(() {
                    loading=false ;
                  });
                    Utils().toastMessage(error.toString());
                  });
                AmountController.clear();
                CatagoryController.clear();
                DescriptionController.clear();
                OtherInformationController.clear();
                })
          ],
        ),
      ),
    );
  }

  // Future<void> ShowMyDialog()async{
  //   return showDialog(
  //     context: context, 
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Update'),
  //         content: Container(
  //           child:TextField() ),
  //       );
  //       },
  
  //   );
  // }


}
