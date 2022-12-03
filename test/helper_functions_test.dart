import 'package:flutter_test/flutter_test.dart';
import 'package:nfc_tagger/functions/helper_functions.dart';
import 'package:nfc_tagger/models/graffito.dart';

void main() {
  //getIdentifier
  test('Should convert identifier to string', () {
    final List<dynamic> list = ["suc", "cess"];
    expect(getIdentifier(list), "success");
  });

  //getReadableDateTime
  test("Should convert time into readable time", () {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(1464418800000);
    expect(getReadableDateTime(time), "2016-05-28");
  });

  //sortByTime
  test(
      "Should sort graffito by the time they were created descending (newest to oldest)",
      () {
    Graffito a = Graffito(
        text: "test",
        timeCreated: DateTime.fromMillisecondsSinceEpoch(10000),
        username: "username");
    Graffito b = Graffito(
        text: "test",
        timeCreated: DateTime.fromMillisecondsSinceEpoch(1000),
        username: "username");
    Graffito c = Graffito(
        text: "test",
        timeCreated: DateTime.fromMillisecondsSinceEpoch(100),
        username: "username");
    List<Graffito> unsorted = [b, c, a];
    List<Graffito> sorted = [a, b, c];
    expect(sortByTime(unsorted), sorted);
  });
}
