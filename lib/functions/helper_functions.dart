import 'package:intl/intl.dart';

import '../models/graffito.dart';

/// * This dart file contains all the helper/reusable functions used for the project to avoid redunancy

String getIdentifier(List identifier) {
  String documentID = "";
  for (var id in identifier) {
    documentID += id.toString();
  }
  return documentID;
}

String getReadableDateTime(DateTime time) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(time);
}

List<Graffito> sortByTime(List<Graffito> list) {
  List<Graffito> toBeReturned = list;
  toBeReturned.sort((a, b) {
    return b.timeCreated.compareTo(a.timeCreated);
  });
  return toBeReturned;
}
