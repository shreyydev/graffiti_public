import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfc_tagger/functions/device_size.dart';
import 'package:nfc_tagger/styles/themes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: DeviceSize.screenHeight / 50,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: DeviceSize.screenWidth / 20, vertical: 0),
            child: Row(
              children: [
                CircleAvatar(
                  minRadius: DeviceSize.screenWidth / 10,
                  backgroundColor: background,
                  child: const Text("F"),
                ),
                SizedBox(
                  width: DeviceSize.screenWidth / 20,
                ),
                const Text(
                  "First Last",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: DeviceSize.screenHeight / 50,
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_box_rounded),
                  title:
                      Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.email_rounded),
                  title: Text("${FirebaseAuth.instance.currentUser!.email}"),
                  onTap: () {},
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () async {
              Navigator.of(context).pop();
              await FirebaseAuth.instance.signOut();
            },
          ),
          SizedBox(
            height: DeviceSize.screenHeight / 50,
          )
        ],
      ),
    );
  }
}
