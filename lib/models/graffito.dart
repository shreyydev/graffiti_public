import 'package:cloud_firestore/cloud_firestore.dart';

/// * Graffiti Record Model (The records that exists on a tag)

class Graffito {
  String text;
  DateTime timeCreated;
  String username;

  Graffito(
      {required this.text, required this.timeCreated, required this.username});

  Map toJson() => {
        'text': text,
        'timeCreated': Timestamp.fromDate(timeCreated),
        'username': username,
      };

  factory Graffito.fromJson(dynamic json) {
    return Graffito(
      text: json['text'] as String,
      timeCreated: (json['timeCreated'] as Timestamp).toDate(),
      username: json['username'],
    );
  }

  @override
  String toString() {
    return "{$text , $timeCreated, $username}";
  }
}
