
import 'package:flutter/material.dart';
import 'package:new_app/Auth/login_or_register.dart';
import 'package:new_app/Pages/Home_page.dart';


import 'package:firebase_auth/firebase_auth.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          //user is logged in
          if(snapshot.hasData){
            return  HomePage();
          }

          //user is not logged in
          else{
            return const LoginOrRegister();
          }

        },
      ),
    );
  }
}