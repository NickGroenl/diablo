import 'dart:convert';

import 'package:diablo/models/zones.dart';
import 'package:http/http.dart' as http;

Future fethZones() async {
  final response = await http.get(Uri.parse('https://www.d2emu.com/api/v1/tz'));
  List<dynamic> nows = json.decode(response.body)['current'];
  List<dynamic> next = json.decode(response.body)['next'];

  nowZones.value = nows.map((dynamic item) => item.toString()).toList() ?? [];
  nextZones.value = next.map((dynamic item) => item.toString()).toList() ?? [];
}