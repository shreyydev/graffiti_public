import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_tagger/screens/stack/profile_screen.dart';
import 'package:nfc_tagger/screens/stack/register_tag_screen.dart';
import 'package:nfc_tagger/screens/widget/graffiti_widget.dart';
import 'package:nfc_tagger/screens/widget/scanning_screen.dart';
import '../../models/tag_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TagData? tagDetails;
  List? identifier;

  @override
  void initState() {
    super.initState();
    lookForNFC();
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  /// not scanned: scanning screen (restart scan button)
  /// scanned: graffiti screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            },
            icon: const Icon(Icons.account_circle_rounded),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "Graffiti",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: identifier == null
          ? const ScanningScreen()
          : GraffitiScreen(
              identifier: identifier!,
            ),
      floatingActionButton: identifier == null
          ? FloatingActionButton.extended(
              onPressed: () {
                NfcManager.instance.stopSession();
                Navigator.pushNamed(
                  context,
                  RegisterTagScreen.routeName,
                ).then((value) {
                  lookForNFC();
                });
              },
              label: const Text(
                "Register a tag",
                style: TextStyle(fontSize: 20),
              ),
              icon: const Icon(Icons.add),
            )
          : FloatingActionButton.extended(
              onPressed: () {
                identifier = null;
                setState(() {});
              },
              label: const Text(
                "Scan another tag",
                style: TextStyle(fontSize: 20),
              ),
              icon: const Icon(Icons.refresh),
            ),
    );
  }
}
