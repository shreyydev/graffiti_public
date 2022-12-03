import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nfc_tagger/functions/arguments.dart';
import 'package:nfc_tagger/styles/themes.dart';

import '../../database/db_operations.dart';
import '../../main.dart';
import '../../models/graffito.dart';

class AddNewGraffito extends StatefulWidget {
  const AddNewGraffito({super.key});
  static String routeName = "/addNewGraffito";

  @override
  State<AddNewGraffito> createState() => _AddNewGraffitoState();
}

class _AddNewGraffitoState extends State<AddNewGraffito> {
  TextEditingController newGraffitoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddNewGraffitiArguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 10, 10),
            child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  await addNewGraffitoInDB(args.list, args.identifier)
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(backgroundColor: secondary),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              controller: newGraffitoController,
              maxLength: 250,
              maxLines: 7,
              decoration: const InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              toolbarOptions: const ToolbarOptions(
                  copy: true, cut: true, paste: true, selectAll: true),
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
