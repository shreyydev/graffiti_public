import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nfc_tagger/models/user.dart';
import 'package:nfc_tagger/screens/widget/alerts.dart';
import 'package:nfc_tagger/screens/widget/text_form_field.dart';

import '../../database/db_operations.dart';
import '../../functions/device_size.dart';
import '../../main.dart';
import '../../styles/themes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.onSignInClick});
  final VoidCallback onSignInClick;

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
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
                    "Let's get you onboard",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: DeviceSize.screenHeight / 10,
                  ),
                  ClassicTextFormField(
                    controller: usernameController,
                    hintText: "Username",
                    isPassword: false,
                    isEmail: false,
                  ),
                  SizedBox(
                    height: DeviceSize.screenHeight / 100,
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
                  ClassicTextFormField(
                    controller: confirmPasswordController,
                    hintText: "Re-Type Password",
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
                      await checkIfUsernameExists(
                              usernameController.text.toLowerCase())
                          .then(
                        (value) async {
                          if (value) {
                            Alerts.showSnackBar("username already exists");
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              Alerts.showSnackBar("Passwords do not match");
                            } else {
                              try {
                                UserCredential result = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                final User user = result.user!;
                                await user.sendEmailVerification();
                                await FirebaseAuth.instance.currentUser!
                                    .updateDisplayName(
                                        usernameController.text.toLowerCase())
                                    .whenComplete(
                                  () async {
                                    await initUser(
                                      GraffitiUser(
                                          firstName: "First",
                                          lastName: "Last",
                                          email: FirebaseAuth
                                              .instance.currentUser!.email!,
                                          username: FirebaseAuth.instance
                                              .currentUser!.displayName!),
                                    );
                                  },
                                );
                              } on FirebaseAuthException catch (e) {
                                Alerts.showSnackBar(e.message);
                              }
                            }
                            navigatorKey.currentState!
                                .popUntil((route) => route.isFirst);
                          }
                        },
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: DeviceSize.screenHeight / 100,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onSignInClick,
                          text: "Log in",
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
        ),
      ),
    );
  }
}
