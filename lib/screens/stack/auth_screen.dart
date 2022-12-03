import 'package:flutter/material.dart';
import 'package:nfc_tagger/screens/widget/login_widget.dart';
import 'package:nfc_tagger/screens/widget/signup_widget.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth_screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginScreen(onSignUpClick: toggle)
        : SignupScreen(onSignInClick: toggle);
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
