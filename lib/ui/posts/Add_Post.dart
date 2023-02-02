import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/ui/posts/StaticClass.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:firebase_test/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final adressController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Student Data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.greenAccent, title: Text('Add firestore data')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Name",
                  label: Text('Name')),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Age",
                  label: Text('Age')
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            
            TextFormField(
              controller: genderController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Gender",
                  label: Text('Gender')
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: adressController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Adress",
                  label: Text('Adress')
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                loading: loading,
                Title: 'Add',
                color: Colors.greenAccent,
                onTap: () {
                  
                  setState(() {
                    StaticClass.i++;
                  });
                  setState(() {
                    loading = true;
                  });
                  databaseRef.child('cosc2121010${StaticClass.i}').child('Data').set({
                    'i':StaticClass.i,
                    'id': 'cosc2121010${StaticClass.i}',
                    'Name': nameController.text.toString(),
                    'Description': 'Kiya hall hai janab',
                    'age': ageController.text.toString(),
                    'Gender': genderController.text.toString(),
                    'Adress': adressController.text.toString(),
                  }).then((value) {
                    Utils().toastMessage('Post Added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage('Post Added');
                    setState(() {
                      loading = false;
                    });
                  });
                  setState(() {
                    nameController.clear();
                    ageController.clear();
                    adressController.clear();
                    genderController.clear();
                  });
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
