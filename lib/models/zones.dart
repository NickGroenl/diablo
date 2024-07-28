// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';

ValueNotifier<List<ZoneModel>> currentZones = ValueNotifier(<ZoneModel>[]);
ValueNotifier<int> currentTime = ValueNotifier<int>(35);
ValueNotifier<int> botState = ValueNotifier<int>(0);

ValueNotifier<List<String>> nowZones = ValueNotifier(<String>[]);
ValueNotifier<List<String>> nextZones = ValueNotifier(<String>[]);


class ZoneModel {
  late String id = '';
  late String title = 'No encontrado';
  late String code = '';
  late String state = 'false';
  ZoneModel();
  ZoneModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'] ?? '';
      title = jsonMap['title'] ?? '';
      code = jsonMap['code'].toString() ?? '7';
      state = jsonMap['state'] ?? 'false';
      // ignore: empty_catches
    } catch (value) {}
  }
  Map<String, dynamic> toJson() {
     return {
      'id': id ?? '',
      'title': title ?? '',
      'code': code.toString() ?? '7',
      'state': state ?? 'false'
    };
  }
}

const zones = [
    {"code": 7, "title": "Burial Grounds - Crypt - Mausoleum"},
    {"code": 33, "title": "Cathedral - Catacombs"},
    {"code": 3, "title": "Cold Plains - Cave"},
    {"code": 5, "title": "Darkwood - Underground Passage"},
    {"code": 2, "title": "Blood Moor - Den of Evil"},
    {"code": 28, "title": "Jail - Barracks"},
    {"code": 39, "title": "Moo Moo Farm"},
    {"code": 4, "title": "Stony Field"},
    {"code": 6, "title": "Black Marsh - The Hole"},
    {"code": 20, "title": "Forgotten Tower"},
    {"code": 12, "title": "Pit"},
    {"code": 38, "title": "Tristram"},
    {"code": 47, "title": "Lut Gholein Sewers"},
    {"code": 41, "title": "Stony Tomb - Rocky Waste"},
    {"code": 42, "title": "Dry Hills - Halls of the Dead"},
    {"code": 43, "title": "Far Oasis"},
    {"code": 44, "title": "Lost City - Valley of Snakes - Claw Viper Temple"},
    {"code": 65, "title": "Ancient Tunnels"},
    {"code": 66, "title": "Tal Rasha's Tombs"},
    {"code": 74, "title": "Arcane Sanctuary"},
    {"code": 76, "title": "Spider Forest - Spider Cavern"},
    {"code": 77, "title": "Great Marsh"},
    {"code": 78, "title": "Flayer Jungle and Dungeon"},
    {"code": 80, "title": "Kurast Bazaar - Temples"},
    {"code": 83, "title": "Travincal"},
    {"code": 100, "title": "Durance of Hate"},
    {"code": 104, "title": "Outer Steppes - Plains of Despair"},
    {"code": 106, "title": "City of the Damned - River of Flame"},
    {"code": 108, "title": "Chaos Sanctuary"},
    {"code": 110, "title": "BloodyFoothills - FrigidHighlands - Abbadon"},
    {"code": 112, "title": "Arreat Plateau - Pit of Acheron"},
    {"code": 113, "title": "Crystalline Passage - Frozen River"},
    {"code": 121, "title": "Nihlathak's Temple and Halls"},
    {"code": 115, "title": "Glacial Trail - Drifter Cavern"},
    {"code": 118, "title": "Ancient's Way - Icy Cellar"},
    {"code": 128, "title": "Worldstone Keep - Throne of Destruction - Worldstone Chamber"}
];
