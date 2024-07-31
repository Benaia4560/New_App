import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/my_backbutton.dart';
import 'package:new_app/components/my_list_tile.dart';
import 'register_page.dart';



class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context ,snapshot){
          //any errors
          if(snapshot.hasError){
            displayMessageToUser("something went wrong", context);
          }

          //show loading circle
          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Center(
              child:CircularProgressIndicator() ,
              );
          }
          if (snapshot.data == null ){
            return const Text("No Data");
          }

          //get all users
          
          final users =snapshot.data!.docs;

          return Column(
            children: [

              //BackButton
              const Padding(
                padding: EdgeInsets.only(
                  top:50,
                  left:25,
                ),
                child: Row(
                  children: [
                    MyBackbutton(),
                  ],
                ),
              ),
              
              
              Expanded(
                child: ListView.builder(
                  itemCount:users.length,
                  padding:const EdgeInsets.all(0),
                  itemBuilder: (context,index){
                    //get individual user
                
                    final user =users[index];

                    //get data from each user
                    String userName=user['userName'];
                    String email=user['email'];
                    int timestamp=user['Timestamp'];

                
                    return MyListTile(title: userName, subtitle: email, timestamp: timestamp,);

                
                  }
                
                  
                ),
              ),
            ],
          
          );
        }
      ),
    );
  }
}

