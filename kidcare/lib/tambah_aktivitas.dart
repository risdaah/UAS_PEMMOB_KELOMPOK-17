import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kidcare/homepengasuh.dart';

class AddAktivitasScreen extends StatefulWidget {
  final int id_pengasuh;
  final int id_user;
  final int id_booking;
  final String namaAnak;

  AddAktivitasScreen({
    required this.id_pengasuh,
    required this.id_user,
    required this.namaAnak,
    required this.id_booking,
  });

  @override
  _AddAktivitasScreenState createState() => _AddAktivitasScreenState();
}

class _AddAktivitasScreenState extends State<AddAktivitasScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aktivitasController = TextEditingController();

  Future<void> _tambahAktivitas() async {
    if (_formKey.currentState!.validate()) {
      final String apiUrl = 'http://127.0.0.1:8000/tambah_aktivitas/';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'aktivitas': _aktivitasController.text,
          'id_pengasuh': widget.id_pengasuh,
          'id_user': widget.id_user,
        }),
      );

      if (response.statusCode == 201) {
        json.decode(response.body);
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xFFFF7A8F),
              ),
              SizedBox(width: 10),
              Text(
                'Aktivitas Berhasil Dikirim',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF7A8F),
                ),
              ),
            ],
          ),
          content: Text(
            'Laporan aktivitas baru untuk ${widget.namaAnak} telah berhasil dikirim',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A8F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomePengasuh(
                      id_pengasuh: widget.id_pengasuh,
                    ),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _updateStatusBooking() async {
    final String apiUrl = 'http://127.0.0.1:8000/update_status_booking/';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_booking': widget.id_booking,
      }),
    );

    if (response.statusCode == 200) {
      json.decode(response.body);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xFFFF7A8F),
              ),
              SizedBox(width: 10),
              Text(
                'Yeay',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF7A8F),
                ),
              ),
            ],
          ),
          content: Text(
            'Terimakasih telah menjaga ${widget.namaAnak}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A8F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomePengasuh(
                      id_pengasuh: widget.id_pengasuh,
                    ),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Handle error
    }
  }

  @override
  void dispose() {
    _aktivitasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Set this height as needed
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(20), // Adjust the radius as needed
          ),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFFF7A8F),
            flexibleSpace: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 5.0),
                // Add padding to adjust the position
                child: Text(
                  'Tambah Aktivitas',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 300.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 188, 188, 188)
                            .withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _aktivitasController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan aktivitas',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 188, 188, 188),
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an aktivitas';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7A8F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          _tambahAktivitas();
                        },
                        // Nanti muncul notif di ortu
                        child: const Text(
                          'Aktivitas Selesai',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7A8F),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Nanti statusnya berganti ke Selesai
                        onPressed: () {
                          _updateStatusBooking();
                        },
                        child: const Text(
                          'Tugas Selesai',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
