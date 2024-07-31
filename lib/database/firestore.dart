// import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
This database stores posts that users have published in the app
It is stored in a collection called 'posts' in Firestore

Each posts contains:
-a messsage
-email of user
-timestamp




*/






class FirestoreDatabase{
  //current logged in user 
  User? user =FirebaseAuth.instance.currentUser;


  //get collection of posts from firebase
  final CollectionReference posts =
  FirebaseFirestore.instance.collection("posts");


  //post a message 
  Future<void>adpost(String message){
    return posts.add({
      'UserEmail':user!.email,
      'postMessage':message,
      'TimeStamp':Timestamp.now(),
    });
  }


  //read post from database
  Stream<QuerySnapshot>getPostsStream(){
    final postStream=FirebaseFirestore
    .instance
    .collection('posts')
    .orderBy(
      'Timestamp',descending: true
    ).snapshots();

    return postStream;
  }

}