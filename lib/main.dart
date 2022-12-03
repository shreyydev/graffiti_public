import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// * App starting point - main()

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    scaffoldMessengerKey: Alerts.messengerKey,
    navigatorKey: navigatorKey,
    title: 'Graffiti',
    debugShowCheckedModeBanner: false,
    theme: primaryTheme,
    routes: {
      HomeScreen.routeName: (context) => const HomeScreen(),
      RegisterTagScreen.routeName: (context) => const RegisterTagScreen(),
      AuthScreen.routeName: (context) => const AuthScreen(),
      AddNewGraffito.routeName: (context) => const AddNewGraffito(),
      ProfileScreen.routeName: (context) => const ProfileScreen(),
    },
    home: const GraffitiApp(),
  ));
}

final navigatorKey = GlobalKey<NavigatorState>();

class GraffitiApp extends StatelessWidget {
  const GraffitiApp({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceSize.init(context: context);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
