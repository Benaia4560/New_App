import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  //logout user
  void logout(){
    FirebaseAuth.instance.signOut();  
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        //drawer header
        Column(children: [
        DrawerHeader(
          child: Icon(
            Icons.favorite,
            color:  Theme.of(context).colorScheme.inversePrimary,
            ),
        ),
        const SizedBox(height: 25),

        //home title
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
            title:const Text("H O M E"),
            onTap: (){}
              //this is already the home screen just pop dra},
            ),
        ),

        //profile title
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
            title:const Text("P R O F I L E"),
            onTap: (){
              //pop drawer
              Navigator.pop(context);

              //navigate to profile page
              Navigator.pushNamed(context, '/profile_page');

            }
              
              
              
            ),
        ),
        //user title
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListTile(
            leading: Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
            title: const Text("U S E R S"),
            onTap: (){
              //pop drawers
             Navigator.pop(context);

              //navigate to profile page
              Navigator.pushNamed(context, '/users_page');
              

            }
              //this is already the home screen just pop dra},
            ),
        ),
        ]
        ),

        //logout title
        Padding(
          padding: const EdgeInsets.only(left: 25.0,bottom: 25),
          child: ListTile(
            leading: Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
            title: const  Text("L O G O U T"),
            onTap: (){
              Navigator.pop(context);

              //logout
              logout();
            }
              //this is already the home screen just pop dra},
            ),
        ),





      ],),
    );
  }
}