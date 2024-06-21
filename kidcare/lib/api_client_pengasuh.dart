import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data_pengasuh.dart';

class APIClient {
  static const _baseUrl = 'http://localhost:8000';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/login_pengasuh');
    final response = await http.post(
      url,
      body: {'username': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    } else {
      return false;
    }
  }

  Future<Pengasuh?> getUserData(String token, {required int idPengasuh}) async {
    final url = Uri.parse('$_baseUrl/api/pengasuh/$idPengasuh');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pengasuh(
        idPengasuh: data['id_pengasuh'],
        nama: data['nama'],
        tglLahir: data['tgl_lahir'],
        alamat: data['alamat'],
        sertifikasi: data['sertifikasi'],
        pengalaman: data['pengalaman'],
        tarif: data['tarif'],
        email: data['email'],
        telp: data['telp'],
        fotoPengasuh: data['foto_pengasuh'],
        password: data['password'],
        umur: data['umur'],
        deskripsi: data['deskripsi'],
      );
    } else {
      return null;
    }
  }
}
