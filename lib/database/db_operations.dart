import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nfc_tagger/functions/constants.dart';
import 'package:nfc_tagger/functions/helper_functions.dart';

import '../models/graffito.dart';
import '../models/tag_data.dart';
import '../models/user.dart';

/// * Operations needed for database
/// AddTag(DocumentID) : Makes a new document in the tags collection with the given ID name which would be the serial id of the tag.
/// getTagData(DocumentID) : Get all the data about a tag with the document ID
/// addGraffitiToTag(DocumentID, TagData) : Given a Document ID, write the TagData to that document.
/// updateUsername(username) : Uses the currently signed in user and updates their username
/// UserAuthentication

//* Tags
Future<String> addTag(List identifier) async {
  var db = FirebaseFirestore.instance;
  String result = Constants.SOME_WRONG;
  await checkIfTagExists(identifier).then((value) {
    if (!value) {
      db.collection("tags").doc(getIdentifier(identifier)).set({
        'graffiti': [],
        'key': 'This is a secure key',
      });
      result = Constants.TAG_ADDED;
    } else {
      result = Constants.TAG_EXISTS;
    }
  });
  return result;
}

Future<bool> checkIfTagExists(List identifier) async {
  var db = FirebaseFirestore.instance;
  DocumentSnapshot doc =
      await db.collection("tags").doc(getIdentifier(identifier)).get();
  return doc.exists;
}

Future<TagData?> getTagData(List identifier) async {
  if (await checkIfTagExists(identifier)) {
    var db = FirebaseFirestore.instance;
    var value =
        await db.collection("tags").doc(getIdentifier(identifier)).get();
    var tagData = TagData.fromJson(value.data());
    return tagData;
  } else {
    return TagData(null, null);
  }
}

//* Graffiti
Future<bool> addNewGraffiti(List<Graffito> graffiti, List identifier) async {
  var db = FirebaseFirestore.instance;
  bool result = false;
  await checkIfTagExists(identifier).then((value) async {
    if (!value) {
      // tag did not exist;
    } else {
      await db.collection("tags").doc(getIdentifier(identifier)).update(
        {'graffiti': graffiti.map((graffito) => graffito.toJson()).toList()},
      );
    }
  });
  return result;
}

// * User
//! How about we initialize the user once he picks his username and shit?
Future<void> initUser(GraffitiUser user) async {
  var db = FirebaseFirestore.instance;
  db.collection("users").doc(user.username).set(user.toJson());
}

Future<bool> updateUsername(username) async {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) return false;
  var db = FirebaseFirestore.instance;
  await db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'username': username});
  return true;
}

Future<bool> checkIfUsernameExists(String username) async {
  var db = FirebaseFirestore.instance;
  DocumentSnapshot doc = await db.collection("users").doc(username).get();
  return doc.exists;
}
