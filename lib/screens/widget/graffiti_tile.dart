import 'package:flutter/material.dart';
import 'package:nfc_tagger/models/graffito.dart';
import 'package:nfc_tagger/styles/themes.dart';

import '../../functions/helper_functions.dart';

ListTile graffitiTile(Graffito tagData) {
  return ListTile(
    tileColor: primaryTheme.cardColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(width: 2)),
    minVerticalPadding: 20,
    title: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        tagData.text,
        textAlign: TextAlign.end,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    ),
    leading: const Icon(Icons.account_circle_rounded),
    subtitle: Text(
      "${tagData.username} | ${getReadableDateTime(tagData.timeCreated)}",
      textAlign: TextAlign.end,
    ),
    onTap: (() {}),
  );
}
