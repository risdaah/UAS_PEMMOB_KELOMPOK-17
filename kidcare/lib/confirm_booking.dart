import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';

class ConfirmBooking extends StatelessWidget {
  final Map<String, dynamic> bookingData;
  final int? id_user;

  ConfirmBooking({required this.bookingData, this.id_user});

  Future<void> _saveBooking(BuildContext context) async {
    // Implementasi logika penyimpanan booking ke database
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/tambah_bookings/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bookingData),
      );

      if (response.statusCode == 201) {
        // Menampilkan pop-up indikator booking berhasil
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.3,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24),
                    Text(
                      'SELESAI',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: Color(0xFFFF7A8F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 22),
                    Text(
                      'Lakukan pembayaran secara langsung pada pengasuh ditempat!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        );

        // Menunggu 5 detik sebelum mengarahkan ke homepage
        await Future.delayed(Duration(seconds: 3));
        Navigator.of(context).pop(); // Menutup dialog
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    userId: id_user,
                  )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuat booking: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFFFF7A8F),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'CONFIRM BOOKING',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 25,
                                color: Color(0xFFFF7A8F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              bookingData['nama_pengasuh'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 236, 239),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Nama Pengasuh',
                                    bookingData['nama_pengasuh']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Tanggal Mulai',
                                    bookingData['tgl_mulai']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(
                                    context,
                                    'Tanggal Selesai',
                                    bookingData['tgl_selesai']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Waktu Mulai',
                                    bookingData['waktu_mulai']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Waktu Selesai',
                                    bookingData['waktu_selesai']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Nama Anak',
                                    bookingData['nama_anak']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Umur Anak',
                                    bookingData['umur_anak']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(
                                    context,
                                    'Daftar Kegiatan',
                                    bookingData['daftar_kegiatan']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(
                                    context, 'Catatan', bookingData['catatan']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(context, 'Detail Alamat',
                                    bookingData['patokan_rumah']),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: _buildInfoItem(
                                    context, 'status', bookingData['status']),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 80.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'TOTAL PEMBAYARAN',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF7A8F),
                                      ),
                                    ),
                                    Expanded(
                                        child:
                                            SizedBox()), // Widget kosong sebagai spacer
                                    Text(
                                      '1.000.000',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFF7A8F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF7A8F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _saveBooking(context);
                },
                child: const Text(
                  'KONFIRMASI',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Container(
        width: screenWidth - 40, // Menggunakan lebar layar - padding horizontal
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFF7A8F),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
