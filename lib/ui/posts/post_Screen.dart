import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_test/ui/auth/loging_Screen.dart';
import 'package:firebase_test/ui/posts/Add_Post.dart';
import 'package:firebase_test/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref=FirebaseDatabase.instance.ref('Student Data');
  final searchFilter=TextEditingController();
  final myNameUpdate=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Posts'),
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
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.greenAccent,
      onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddPosts()));
      },
    child: Icon(Icons.add),),
  body:  ListView(  
    children: [
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: searchFilter,
            onChanged: (String value) {
              setState(() {
                
              });
            },
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder()
            ),
          ),
        ),
      Container(
        height: 300,
        child: Expanded(child:StreamBuilder(
          stream: ref.onValue,
          builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
            if(!snapshot.hasData){
              return CircularProgressIndicator(
                strokeWidth: 4.0,
                semanticsLabel: 'Just wait',
                value: 10,
              );
            }else{
              Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
              List<dynamic>list=[];
              list.clear();
              list=map.values.toList();
            return ListView.builder(
              itemCount: snapshot.data!.snapshot.children.length,
              itemBuilder: (context,index){
                final Name=list[index]['Data']['Name'];
                if(searchFilter.text.isEmpty){
                  return ListTile(
                title: Text(list[index]['Data']['Name']),
                subtitle:  Text('Age : '+list[index]['Data']['age']+',  Gender : '+list[index]['Data']['Gender']),
                leading:  Column(
                  children: [
                    Text(list[index]['Data']['Adress']),
                    Text(list[index]['Data']['id']),
                  ],
                ),
                trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                      onTap: (){
                        Navigator.pop(context);
                        ShowMyDialogs(Name,list[index]['Data']['id']);
                      },
                    )),
                    PopupMenuItem(
                      value: 1,
                      onTap: (){
                        ref.child(list[index]['Data']['id']).remove();
                      },
                      child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ))
                  ],),
              );
                }
                else if(Name.toLowerCase().contains(searchFilter.text.toLowerCase().toLowerCase())){
                  return ListTile(
                title: Text(list[index]['Data']['Name']),
                trailing:  Text(list[index]['Data']['id']),
                subtitle:  Text(list[index]['Data']['age']+''+list[index]['Data']['Gender']),
                leading:  Text(list[index]['Data']['Adress']),
              );
                }
                else{
                 return Container();
                }
                
              // return ListTile(
              //   title: Text(list[index]['Data']['Name']),
              //   trailing:  Text(list[index]['Data']['id']),
              //   subtitle:  Text(list[index]['Data']['age']+''+list[index]['Data']['Gender']),
              //   leading:  Text(list[index]['Data']['Adress']),
              // );
            });
          
            }
}
        )),
      ),
    
    ],
  ),
    );
  }
  
  Future<void> ShowMyDialogs(String myName,String myid)async{
    myNameUpdate.text=myName;
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child:TextFormField(
              controller: myNameUpdate,
            ) ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Calcel")),
              TextButton(onPressed: (){
                Navigator.pop(context);
                ref.child(myid).update({
                  'Name':myNameUpdate.text.toString()
                }).then((value){
                  Utils().toastMessage('Post Updated');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
              }, child: Text("Update"))
            ],
        );
        },
  
    );
  }


}

  // Container(
  //       color: Colors.greenAccent.shade200,
  //       height: 300,
  //       child: Expanded(
  //         child: FirebaseAnimatedList(
  //           // reverse: true,
  //           query: ref,
  //          itemBuilder: (context,snapshot,animation,index){
            
  //           return ListTile(
  //             title: Text(snapshot.child('Data').child('Name').value.toString()),
  //             trailing: Text(snapshot.child('Data').child('id').value.toString()),
  //             subtitle: Text('Age ${snapshot.child('Data').child('age').value} Gender ${snapshot.child('Data').child('Gender').value}'),
  //             leading: Text(snapshot.child('Data').child('Adress').value.toString()),
              
  //           );
  //          }),
  //       ),
  //     )