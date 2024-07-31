
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/my_button.dart';
import 'package:new_app/components/my_textField.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpwController = TextEditingController();

  // Register method
  void registerUser() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Make sure passwords match
    if (passwordController.text != confirmpwController.text) {
      // Pop loading circle
      Navigator.pop(context);

      // Show error message to the user
      displayMessageToUser("Passwords don't match!", context);
      return;
    }
    //if password do match
    else{
      //try creating the user

    }
    

    // Try creating the user
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text
              );
              //create a user document and add to firestore
              createUserDocument(userCredential);

      // Pop loading circle
      Navigator.pop(context);

      // Optionally handle successful registration
      if(context.mounted)Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);

      // Display error message to user
      displayMessageToUser(e.code, context);
    }
  }
  //create a user document and add collect them in firestore
  Future<void>createUserDocument(UserCredential?userCredential)async{
    if(userCredential != null && userCredential.user !=null ){
      await FirebaseFirestore.instance
      .collection("users")
      .doc(userCredential.user!.email)
      .set({
        'email':userCredential.user!.email,
        'username':usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.person_add,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              // App name
              const Text(
                "M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),

              // Username text field
              MyTextField(
                hintText: "Username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(height: 10),

              // Email text field
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(height: 10),

              // Password text field
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),

              // Confirm password text field
              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: confirmpwController,
              ),
              const SizedBox(height: 10),

              // Register button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),
              const SizedBox(height: 25),

              // Already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement navigation to login page
                    },
                    child: const Text(
                      " Login Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void displayMessageToUser(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
