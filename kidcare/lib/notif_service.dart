import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data_aktivitas.dart';

class NotifService {
  static Future<List<Aktivitas>> fetchAllNotif() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/tampilkan_semua_aktivitas'));
    if (response.statusCode == 200) {
      List<dynamic> aktivitasJsonList = json.decode(response.body)['data'];
      return aktivitasJsonList
          .map((aktivitasJson) => Aktivitas.fromJson(aktivitasJson))
          .toList();
    } else {
      throw Exception('Failed to load Aktivitass');
    }
  }

  static Future<List<Aktivitas>> fetchotifByUserId(int userId) async {
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/tampilkan_aktivitas_tertentu/?id_user=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> aktivitasJsonList = json.decode(response.body)['data'];
      return aktivitasJsonList
          .map((aktivitasJson) => Aktivitas.fromJson(aktivitasJson))
          .toList();
    } else {
      throw Exception('Failed to load Aktivitass');
    }
  }
}
