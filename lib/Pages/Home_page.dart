
import "package:flutter/material.dart";
import 'package:new_app/components/my_drawer.dart';
import 'package:new_app/components/my_list_tile.dart';
import 'package:new_app/components/my_post_button.dart';
import 'package:new_app/components/my_textField.dart';
import 'package:new_app/database/firestore.dart';








class HomePage extends StatelessWidget {
   HomePage({super.key});

   //firestore access
   final FirestoreDatabase database =FirestoreDatabase();

  //text controller
 final TextEditingController newPostController =TextEditingController();


  //post message 
  void postMessage(){
    //only post message if there is something in the textfield
    if(newPostController.text.isNotEmpty){
      String message =newPostController.text;
      database.adpost(message);

    }
    //clear the controller
    newPostController.clear();


  }
  

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Textfield Box for user to type
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "Say something..", 
                    obscureText: false, 
                    controller: newPostController,
                  ),
                ),
                // Post Button
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),
          // Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // Show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // Get all posts
              final posts = snapshot.data!.docs;
              // No data
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No post....post something!"),
                  ),
                );
              }
              // Return list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // Get each individual post
                    final post = posts[index];
                    // Get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    int timestamp = post['Timestamp'];
                    // Return as a list tile
                    return MyListTile(
                      title: message,
                      subtitle: userEmail,
                      timestamp: timestamp,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
