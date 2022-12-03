import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_tagger/database/db_operations.dart';

import '../../functions/constants.dart';
import '../widget/alerts.dart';

class RegisterTagScreen extends StatelessWidget {
  const RegisterTagScreen({super.key});
  static String routeName = "/registerTag";

  lookForNFC(BuildContext context) async {
    if (await NfcManager.instance.isAvailable()) {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          var identifier = tag.data.entries.first.value['identifier'];
          _confirm(context, identifier);
        },
      );
    }
  }

  void _confirm(BuildContext context, List identifier) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(
              'Found a tag',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            content: const Text(
              'Do you want to register this tag?',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  lookForNFC(context);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await addTag(identifier).then((value) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    if (value == Constants.TAG_ADDED) {
                      customAlertDialogBox(
                          context,
                          Colors.green,
                          const Icon(Icons.verified_rounded),
                          Constants.TAG_ADDED);
                    } else if (value == Constants.TAG_EXISTS) {
                      customAlertDialogBox(
                          context,
                          Colors.yellow,
                          const Icon(Icons.error_rounded),
                          Constants.TAG_EXISTS);
                    } else if (value == Constants.SOME_WRONG) {
                      customAlertDialogBox(
                          context,
                          Colors.red,
                          const Icon(Icons.error_rounded),
                          Constants.SOME_WRONG);
                    }
                  });
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          );
        });
  }

  dispose() {
    NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    lookForNFC(context);
    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Scanning for new tags...",
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(
              height: height / 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
}
