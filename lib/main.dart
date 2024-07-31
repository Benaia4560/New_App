import 'package:firebase_core/firebase_core.dart';
import'package:flutter/material.dart';
import 'package:new_app/firebase_options.dart';
import 'Auth/login_or_register.dart';
import 'Pages/Home_page.dart';
import 'Pages/profile_page.dart';
import 'Pages/user_page.dart';

import 'Auth/Auth.dart';





import 'Theme/dark_mode.dart';
import 'Theme/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform); 
  runApp(const MyApp());

}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,

  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Colors.grey[800],
    displayColor: Colors.black
  )
),
      darkTheme: darkMode,
      routes: {
        '/login_register_page':(context)=>const LoginOrRegister(),
        '/home_page':(context)=> HomePage(),
        '/profile_page':(context)=> ProfilePage(),
        '/users_page':(context)=>const UserPage(),
      },
    );
  }
}