import 'package:flutter/material.dart';
import 'package:new_app/Pages/Login_page.dart';
import 'package:new_app/Pages/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  _LoginOrRegisterState createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  // Toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return const RegisterPage();
    }
  }
}
