import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/ui/firesStore/StaticClass.dart';
import 'package:firebase_test/ui/posts/StaticClass.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:firebase_test/widgets/round_button.dart';
import 'package:flutter/material.dart';

class Add_Expanse_Firestore extends StatefulWidget {
  const Add_Expanse_Firestore({super.key});

  @override
  State<Add_Expanse_Firestore> createState() => _Add_Expanse_FirestoreState();
}

class _Add_Expanse_FirestoreState extends State<Add_Expanse_Firestore> {
  final MyFireFtoress=FirebaseFirestore.instance.collection('Expanse');
  final exAmountController = TextEditingController();
  final exCatagoryController = TextEditingController();
  final exDescriptionController = TextEditingController();
  final exOtherInformationController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Student Data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.red.shade300, title: Text('Add Expanse Data ')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: exAmountController,
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
              controller: exCatagoryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Category",
                  label: Text('Category')
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            
            TextFormField(
              controller: exDescriptionController,
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
                Title: 'Add Expense',
                color: Colors.red.shade300,
                onTap: () {
                  setState(() {
                    loading=true;
                    // myStaticClass.z++;
                  });
                  String exid=DateTime.now().millisecondsSinceEpoch.toString();
                  MyFireFtoress.doc(exid).set({
                    
                      'exmyId':exid,
                      'examount':exAmountController.text,
                       'excatagory':exCatagoryController.text.toString(),
                       'exdescription':exDescriptionController.text.toString(),
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
                exAmountController.clear();
                exCatagoryController.clear();
                exDescriptionController.clear();
                exOtherInformationController.clear();
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
