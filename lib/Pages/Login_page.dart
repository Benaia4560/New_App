
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/components/my_button.dart';
import 'package:new_app/components/my_textField.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Login method
  void login() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Try to sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Pop loading circle if the context is still mounted
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);
      
      // Display error message to user
      displayMessageToUser(e.message ?? "An error occurred", context);
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
                Icons.person,
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

              // Forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Sign in button
              MyButton(
                text: "Login",
                onTap: login,
              ),
              const SizedBox(height: 25),

              // Don't have an account? Register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register Here",
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
