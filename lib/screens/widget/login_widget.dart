import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nfc_tagger/functions/device_size.dart';
import 'package:nfc_tagger/screens/widget/alerts.dart';
import 'package:nfc_tagger/screens/widget/text_form_field.dart';
import 'package:nfc_tagger/styles/themes.dart';

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignUpClick;
  const LoginScreen({super.key, required this.onSignUpClick});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Graffiti!",
                style: TextStyle(fontSize: 60),
              ),
              SizedBox(
                height: DeviceSize.screenHeight / 40,
              ),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: DeviceSize.screenHeight / 10,
              ),
              ClassicTextFormField(
                controller: emailController,
                hintText: "Email",
                isPassword: false,
                isEmail: true,
              ),
              SizedBox(
                height: DeviceSize.screenHeight / 100,
              ),
              ClassicTextFormField(
                controller: passwordController,
                hintText: "Password",
                isPassword: true,
                isEmail: false,
              ),
              SizedBox(
                height: DeviceSize.screenHeight / 100,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: secondary,
                ),
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                  } on FirebaseAuthException catch (e) {
                    Alerts.showSnackBar(e.message);
                  }
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(
                height: DeviceSize.screenHeight / 100,
              ),
              RichText(
                text: TextSpan(
                  text: "No account? ",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onSignUpClick,
                      text: "Sign Up",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: secondary,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
