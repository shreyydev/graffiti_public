// * TagData Model

import 'package:nfc_tagger/models/graffito.dart';

class TagData {
  List<Graffito>? graffiti;
  String? key;

  TagData(this.graffiti, this.key);

  Map toJson() {
    var jsonGraffiti = graffiti != null
        ? graffiti!.map((graffito) => graffito.toJson()).toList()
        : null;

    return {
      'graffiti': jsonGraffiti,
      'key': key,
    };
  }

  factory TagData.fromJson(dynamic json) {
    var graffitiList = json['graffiti'] as List;
    List<Graffito> graffiti = graffitiList
        .map((graffitiJson) => Graffito.fromJson(graffitiJson))
        .toList();
    return TagData(graffiti, json['key'] as String);
  }

  @override
  String toString() {
    if (graffiti != null) {
      String acc = "";
      for (var graffito in graffiti!) {
        acc += graffito.toString();
      }
      return "{$acc , $key}";
    } else {
      return "{no graffiti, $key}";
    }
  }
}
