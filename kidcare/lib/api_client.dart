import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data_user.dart';

class APIClient {
  static const _baseUrl = 'http://localhost:8000';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/login');
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

  Future<User?> getUserData(String token, {required User currentUser}) async {
    final url = Uri.parse(
        '$_baseUrl/api/users/{user_id}'); // Ganti dengan ID user yang sesuai
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User(
        id_user: data['id_user'],
        nama: 'Nama Pengguna',
        jenis_kelamin: 'Jenis Kelamin',
        tgl_lahir: 'Tanggal Lahir',
        alamat: 'Alamat',
        pekerjaan: 'Pekerjaan',
        email: data['email'],
        foto_user: 'Foto Pengguna',
        password: 'Password',
      );
    } else {
      return null;
    }
  }
}
